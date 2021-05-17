function Set-Regkey ($name, $value){
    New-ItemProperty -Path HKLM:\SOFTWARE -Name $name -Value $value -PropertyType "string" 
}

#-FilePath non obligatoire
function Write-Log($message, $logfile){
    $Date = Get-Date -Format yyyymmdd-hh:mm:ss
    $Message_total = $Date + " > " + $message
    $Message_total | Out-File -FilePath $logfile -Append
}

$clés = @{"Test-Version"=2.0;"Test-Region"="Belgium"} #2.0, string ?
$logfile = "C:\Users\Jérôme\Desktop\Meslogs.txt"

#Attention au passage un peu spécial des paramètres !
Write-Log -logfile $logfile -message "Début du script"

foreach($item in $clés.GetEnumerator()){
    #$message = "Création de la clé {0}" -f $item.Key
    Write-Log -message "Création de la clé $($item.Key)" -logfile $logfile
    Set-Regkey -name $item.Key -value $item.Value
}

Write-Log -logfile $logfile -message "Fin du script"