#Vérifier et agir sur l'état d'un service

function Get-Services() {
    [Cmdletbinding(SupportsShouldprocess=$true)]

    Param(
    [Parameter(mandatory=$true)] $machine,
    [Parameter(mandatory=$true)] $service
    )

    $etat = Get-Service -ComputerName $machine $service
    Write-Host "Etat du service $service : " $etat.status

    if($etat.status -eq "Stopped") {
        $action = Read-Host "Démarrer le service ? (O/N)"
        if($action -eq "O") {
            $etat.Start()
            }
        }
    else {
        $action = Read-Host "Stopper le service ? (O/N)"
        if($action -eq "O") {
            $etat.Stop()
            }
    }
}

$machine = Read-Host "Machine"
$service = Read-Host "Service"

Get-Services -machine $machine -service $service