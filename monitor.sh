# Boucle infinie pour le monitoring continu
while ($true) {
    # Récupération du compteur de temps processeur total
    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    
    # Arrondi à 1 décimale
    $cpu = [math]::Round($cpu, 1)

    # Définition de la couleur selon la charge
    if ($cpu -ge 90) {
        $color = "Red"
    } elseif ($cpu -ge 70) {
        $color = "Yellow"
    } else {
        $color = "Green"
    }

    # Nettoyer la console pour un effet "fixe"
    Clear-Host
    
    # Affichage
    Write-Host "=============================" -ForegroundColor Gray
    Write-Host "   MONITORING CPU (CTRL+C pour quitter)" -ForegroundColor Gray
    Write-Host "=============================" -ForegroundColor Gray
    Write-Host ""
    Write-Host " Utilisation Totale : $cpu %" -ForegroundColor $color
    Write-Host ""
    
    # Pause de 1 seconde avant la prochaine mise à jour
    Start-Sleep -Seconds 1
}
