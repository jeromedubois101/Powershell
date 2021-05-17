
$machine = Read-Host "Machine"

Invoke-Command -ComputerName $machine -ScriptBlock {

function Set-Regkey{
    [Cmdletbinding(SupportsShouldprocess=$true)]

    Param(
        [Parameter(Mandatory=$true)][Validateset("HKLM:\Software\", "HKLM:\System\")]$chemin,
        [Parameter(Mandatory=$true)]$clé,
        [Parameter(Mandatory=$true)]$value
        )

    try{
        New-ItemProperty -Path $chemin -Name $clé -Value $value -PropertyType "string" -ErrorAction Stop | Out-Null
        Write-Host "Succès sans forcer"
    }
    catch{
        New-ItemProperty -Path $chemin -Name $clé -Value $value -PropertyType "string" -ErrorAction Stop -Force | Out-Null
        Write-Host "Succès en forçant"
        #Write-Host $Error[0] = Cette propriété existe déjà
    }
}

$clé = Read-Host "Nom clé"
$value = Read-Host "Valeur"

$chemin = @{"1"="HKLM:\Software\";"2"="HKLM:\System\"}
$choix_chemin = "aucun"

while(($choix_chemin -ne "1") -and ($choix_chemin -ne "2")) {
    $choix_chemin  = Read-Host "Chemin `n1 = HKLM:\Software\ `n2 = HKLM:\System\"
}

Set-Regkey -chemin $chemin[$choix_chemin] -clé $clé -value $value

}