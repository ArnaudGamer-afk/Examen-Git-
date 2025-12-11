while ($true) {
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
