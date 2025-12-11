while ($true) {
    # Récupère la charge CPU
    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    $cpu = [math]::Round($cpu, 1)

    # Gestion couleur
    if ($cpu -ge 90) { $c = "Red" } elseif ($cpu -ge 70) { $c = "Yellow" } else { $c = "Green" }

    # Affichage propre
    Clear-Host
    Write-Host "=== CPU WATCHER ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host " Charge Actuelle : $cpu %" -ForegroundColor $c
    
    Start-Sleep -Seconds 1
}
