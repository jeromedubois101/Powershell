function Set-Regkey ($name, $value){
    #On peut passer le path en paramètre
    #ErrorAction Stop super important car le catch ne fonctionne qu'avec les erreurs qui arrêtent le script
    New-ItemProperty -Path HKLM:\SOFTWARE -Name $name -Value $value -PropertyType "string" -ErrorAction Stop | Out-Null
}

function Write-Log($message, $logfile){
    $Date = Get-Date -Format yyyyMMdd-hh:mm:ss
    $Message_total = $Date + " > " + $message
    $Message_total | Out-File -FilePath $logfile -Append
}

$clés = @{"Test-Version"=2.0;"Test-Region"="Belgium"}
$logfile = "C:\Users\Jérôme\Desktop\Meslogs.txt"

Write-Log -logfile $logfile -message "Début du script"

foreach($item in $clés.GetEnumerator()){
    Write-Log -message "Création de la clé $($item.Key)" -logfile $logfile
    try
    {
    Set-Regkey -name $item.Key -value $item.Value
    Write-Log -message "Création réussie"-logfile $logfile 
    }
    catch
    {
    #$ErrorMessage = $_.Exception.Message
    Write-Log -message "Erreur, création impossible"-logfile $logfile
    }
    finally
    {
    Write-Log -message "Fin de la gestion de la clé" -logfile $logfile
    }
}

Write-Log -logfile $logfile -message "Fin du script"
