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

$desktop = [Environment]::GetFolderPath("DesktopDirectory")

if ([string]::IsNullOrWhiteSpace($desktop)) {
    $desktop = [Environment]::GetFolderPath("Desktop")
}

$trigger = Join-Path $desktop "HDT_ONECLICK_EXPORT.trigger"
$status = Join-Path $desktop "HDT_ONECLICK_EXPORT.status"

Remove-Item $status -Force -ErrorAction SilentlyContinue

[System.IO.File]::WriteAllText(
    $trigger,
    (Get-Date).ToString("o"),
    (New-Object System.Text.UTF8Encoding($false))
)

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " HDT ONE-CLICK COLLECTION EXPORTER" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host (T "Export request sent to HDT." "Richiesta di esportazione inviata a HDT.")
Write-Host (T "Make sure Hearthstone and HDT are open." "Assicurati che Hearthstone e HDT siano aperti.")
Write-Host ""

$deadline = (Get-Date).AddSeconds(90)

while ((Get-Date) -lt $deadline) {
    Start-Sleep -Milliseconds 500

    if (Test-Path $status) {
        $message = [System.IO.File]::ReadAllText($status)
        Remove-Item $status -Force -ErrorAction SilentlyContinue

        if ($message.StartsWith("OK|")) {
            Write-Host (T "EXPORT COMPLETED" "ESPORTAZIONE COMPLETATA") -ForegroundColor Green
            Write-Host ""
            Write-Host $message.Substring(3) -ForegroundColor Green
            exit 0
        }

        if ($message.StartsWith("ERROR|")) {
            Write-Host (T "EXPORT FAILED" "ESPORTAZIONE NON RIUSCITA") -ForegroundColor Red
            Write-Host ""
            Write-Host $message.Substring(6)
            exit 1
        }

        Write-Host (T "Unexpected plugin response:" "Risposta inattesa dal plugin:") -ForegroundColor Yellow
        Write-Host $message
        exit 1
    }
}

Write-Host (T "Timeout: the plugin did not respond within 90 seconds." "Timeout: il plugin non ha risposto entro 90 secondi.") -ForegroundColor Red
Write-Host ""
Write-Host (T "Check that the plugin is enabled in Options > Tracker > Plugins." "Controlla che il plugin sia abilitato in Options > Tracker > Plugins.")
exit 1
