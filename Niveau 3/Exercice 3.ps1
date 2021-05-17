function Set-Regkey{
    [Cmdletbinding(SupportsShouldprocess=$true)]

    Param(
        [Parameter()]$machine,
        [Parameter()][Validateset("HKLM:\Software\", "HKLM:\System\")]$chemin,
        [Parameter()]$clé,
        [Parameter()]$value
        )

    try{
        New-ItemProperty -Path $chemin -Name $clé -Value $value -PropertyType "string" -ErrorAction Stop
        Write-Host "Succès sans forcer"
    }
    catch{
        New-ItemProperty -Path $chemin -Name $clé -Value $value -PropertyType "string" -ErrorAction Stop -Force
        Write-Host "Succès en forçant"
        Write-Host $Error[0]
    }
}

$machine = Read-Host "Machine"
$clé = Read-Host "Nom clé"
$value = Read-Host "Valeur"

$chemin = @{"1"="HKLM:\Software\";"2"="HKLM:\System\"}
$choix_chemin = "aucun"

while(($choix_chemin -ne "1") -and ($choix_chemin -ne "2")) {
    $choix_chemin  = Read-Host "Chemin `n1 = HKLM:\Software\ `n2 = HKLM:\System\"
}

Set-Regkey -machine $machine -chemin $chemin[$choix_chemin] -clé $clé -value $value