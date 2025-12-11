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
    # ERREUR VOLONTAIRE ICI (Regarde bien le nom de la commande)
    $os = Get-CimInstancee Win32_OperatingSystem

    # Le reste du calcul
    $total = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
    $free  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
    $used  = $total - $free
    $perc  = [math]::Round(($used / $total) * 100, 1)

    if ($perc -ge 90) { $c = "Red" } elseif ($perc -ge 70) { $c = "Yellow" } else { $c = "Green" }

    Clear-Host
    Write-Host "=== RAM ===" -ForegroundColor Gray
    Write-Host " $used / $total GB" -ForegroundColor $c
    
    Start-Sleep -Seconds 1
}
