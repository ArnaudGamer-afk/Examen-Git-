while ($true) {
    $os = Get-CimInstance Win32_OperatingSystem
    $total = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
    $free  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
    $used  = $total - $free
    $perc  = [math]::Round(($used / $total) * 100, 1)

    if ($perc -ge 90) { $c = "Red" } elseif ($perc -ge 70) { $c = "Yellow" } else { $c = "Green" }

    Clear-Host
    Write-Host "=== RAM MONITOR ===" -ForegroundColor Cyan
    Write-Host "Total   : $total GB"
    Write-Host "Utilisé : $used GB"
    Write-Host "Charge  : $perc %" -ForegroundColor $c
    Start-Sleep -Seconds 1
}
