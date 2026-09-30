param(
    [ValidateSet("en", "it")]
    [string]$Language = "en"
)

function T {
    param([string]$En, [string]$It)
    if ($Language -eq "it") { return $It }
    return $En
}

$plugin = Join-Path $env:APPDATA "HearthstoneDeckTracker\Plugins\HdtOneClickCollectionExporter.dll"

if (Test-Path $plugin) {
    Remove-Item $plugin -Force
    Write-Host (T "Plugin removed. Restart HDT." "Plugin rimosso. Riavvia HDT.") -ForegroundColor Green
}
else {
    Write-Host (T "Plugin file not found." "File del plugin non trovato.") -ForegroundColor Yellow
}
