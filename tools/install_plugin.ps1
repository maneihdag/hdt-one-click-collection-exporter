param(
    [ValidateSet("en", "it")]
    [string]$Language = "en"
)

$ErrorActionPreference = "Stop"

function T {
    param([string]$En, [string]$It)
    if ($Language -eq "it") { return $It }
    return $En
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " HDT ONE-CLICK COLLECTION EXPORTER" -ForegroundColor Cyan
Write-Host (T " INSTALLER" " INSTALLAZIONE") -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$source = Join-Path $repoRoot "src\HdtOneClickCollectionExporter.cs"

if (-not (Test-Path $source)) { throw (T "Plugin source file not found." "File sorgente del plugin non trovato.") }

$hdtExe = $null
try {
    $processes = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object { $_.ExecutablePath -and $_.ExecutablePath -match "Hearthstone.*Deck.*Tracker.*\.exe$" }
    if ($processes) { $hdtExe = ($processes | Select-Object -First 1).ExecutablePath }
} catch {}

if (-not $hdtExe) {
    $roots = @(
        (Join-Path $env:LOCALAPPDATA "HearthstoneDeckTracker"),
        (Join-Path $env:LOCALAPPDATA "Programs\Hearthstone Deck Tracker"),
        (Join-Path $env:APPDATA "HearthstoneDeckTracker"),
        (Join-Path ${env:ProgramFiles} "Hearthstone Deck Tracker")
    ) | Where-Object { $_ -and (Test-Path $_) }

    $hits = @()
    foreach ($root in $roots) {
        try {
            $hits += Get-ChildItem -Path $root -Filter "HearthstoneDeckTracker.exe" -File -Recurse -ErrorAction SilentlyContinue
            $hits += Get-ChildItem -Path $root -Filter "Hearthstone Deck Tracker.exe" -File -Recurse -ErrorAction SilentlyContinue
        } catch {}
    }
    if ($hits) { $hdtExe = ($hits | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName }
}

if (-not $hdtExe -or -not (Test-Path $hdtExe)) {
    Write-Host (T "Hearthstone Deck Tracker was not found." "Hearthstone Deck Tracker non è stato trovato.") -ForegroundColor Red
    Write-Host ""
    Write-Host (T "Open HDT and leave it running, then run the installer again." "Apri HDT e lascialo aperto, poi rilancia l'installer.")
    Write-Host ""
    Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
    exit 1
}

$hdtDir = Split-Path -Parent $hdtExe
Write-Host (T "HDT found:" "HDT trovato:")
Write-Host $hdtExe -ForegroundColor DarkGray
Write-Host ""

try {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName PresentationCore
    Add-Type -AssemblyName WindowsBase
    Add-Type -AssemblyName System.Xaml
    $presentationFramework = [System.Windows.Controls.MenuItem].Assembly.Location
    $presentationCore = [System.Windows.Media.Color].Assembly.Location
    $windowsBase = [System.Windows.DependencyObject].Assembly.Location
    $systemXaml = [System.Xaml.XamlReader].Assembly.Location
}
catch {
    Write-Host (T "Could not load the required WPF libraries." "Impossibile caricare le librerie WPF richieste.") -ForegroundColor Red
    Write-Host $_.Exception.Message
    Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
    exit 1
}

function Find-HdtDll {
    param([string]$Name)
    Get-ChildItem -Path $hdtDir -Filter $Name -File -Recurse -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
}

$newtonsoft = Find-HdtDll "Newtonsoft.Json.dll"
$hearthMirror = Find-HdtDll "HearthMirror.dll"
$hearthDb = Find-HdtDll "HearthDb.dll"

if (-not $newtonsoft) {
    Write-Host "Newtonsoft.Json.dll not found / non trovato." -ForegroundColor Red
    Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
    exit 1
}

$cscCandidates = @(
    "$env:WINDIR\Microsoft.NET\Framework64\v4.0.30319\csc.exe",
    "$env:WINDIR\Microsoft.NET\Framework\v4.0.30319\csc.exe"
)
$csc = $cscCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $csc) {
    Write-Host (T ".NET Framework C# compiler not found." "Compilatore C# .NET Framework non trovato.") -ForegroundColor Red
    Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
    exit 1
}

$pluginDir = Join-Path $env:APPDATA "HearthstoneDeckTracker\Plugins"
New-Item -ItemType Directory -Path $pluginDir -Force | Out-Null
$outputDll = Join-Path $pluginDir "HdtOneClickCollectionExporter.dll"

$references = @($hdtExe,$newtonsoft.FullName,$presentationFramework,$presentationCore,$windowsBase,$systemXaml)
if ($hearthMirror) { $references += $hearthMirror.FullName }
if ($hearthDb) { $references += $hearthDb.FullName }

$args = @("/nologo","/target:library","/optimize+","/platform:anycpu","/out:$outputDll")
foreach ($reference in $references) { $args += "/reference:$reference" }
$args += $source

Write-Host (T "Compiling plugin..." "Compilo il plugin...")
Write-Host ""
& $csc $args

if ($LASTEXITCODE -ne 0 -or -not (Test-Path $outputDll)) {
    Write-Host ""
    Write-Host (T "COMPILATION FAILED" "COMPILAZIONE NON RIUSCITA") -ForegroundColor Red
    Write-Host ""
    Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host (T " PLUGIN INSTALLED" " PLUGIN INSTALLATO") -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host $outputDll -ForegroundColor DarkGray
Write-Host ""
Write-Host (T "Next steps:" "Prossimi passaggi:")
Write-Host (T "1. Fully close HDT, including the tray icon." "1. Chiudi completamente HDT, anche dalla tray.")
Write-Host (T "2. Reopen HDT." "2. Riapri HDT.")
Write-Host (T "3. Go to Options > Tracker > Plugins." "3. Vai in Options > Tracker > Plugins.")
Write-Host (T "4. Enable 'HDT One-Click Collection Exporter'." "4. Abilita 'HDT One-Click Collection Exporter'.")
Write-Host ""
Read-Host (T "Press ENTER to close" "Premi INVIO per chiudere")
