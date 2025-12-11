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

    # Récupère les infos du disque C:
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    
    # Calculs en GB
    $total = [math]::Round($disk.Size / 1GB, 1)
    $free  = [math]::Round($disk.FreeSpace / 1GB, 1)
    $used  = $total - $free
    $perc  = [math]::Round(($used / $total) * 100, 1)

    # Couleur (Si disque plein à 90% = Rouge)
    if ($perc -ge 90) { $c = "Red" } elseif ($perc -ge 75) { $c = "Yellow" } else { $c = "Green" }

    # Affichage
    Clear-Host
    Write-Host "=== DISK (C:) ===" -ForegroundColor Gray
    Write-Host " Utilisé : $used / $total GB"
    Write-Host " Rempli  : $perc %" -ForegroundColor $c
    
    # On rafraîchit moins vite que le CPU (le disque bouge moins)
    Start-Sleep -Seconds 3
}
