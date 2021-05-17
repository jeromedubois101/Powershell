function Get-Services() {
    Param(
    [Parameter(mandatory=$false)]$ComputerName,
    [Parameter(mandatory=$false)][ValidateSet("Running", "Stopped")] $etat_service,
    [Parameter(mandatory=$false)][ValidateRange(2, 10)] $nb_services
    )
    
    Get-Service -ComputerName $ComputerName | select name,status,displayname | ? {$_.Status -eq $etat_service} | select -First $nb_services
}

$machine = Read-Host "Machine : (vide = locale)"
if ($machine -eq ""){
    $machine = $env:COMPUTERNAME
}

$etat_service = @{1="Running";2="Stopped"}
$choix = 0
while (($choix -ne 1) -and ($choix -ne 2)){
    $choix = Read-Host "Running : 1 / Stoppé : 2"
}

$nb_services = Read-Host "Nombre de services (2, 10) :"

Get-Services -ComputerName $machine -etat_service $etat_service[[int]$choix] -nb_services $nb_services