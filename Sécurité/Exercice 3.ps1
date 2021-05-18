# Ajout d'un ordinateur au domaine
# A faire sur un ordinateur hors domaine

Add-Computer -DomainName blanc.local -Credential administrateur@blanc.local

# Création d'OU

cd 'AD:\DC=blanc,DC=local'
mkdir "OU=Professeurs"
mkdir "OU=Etudiants"
mkdir "OU=Administration"

# Ajout des utilisateurs dans le fichier CSV (changer domaine correspondant au préalable)

$users = Import-Csv C:\Users\Administrateur\Desktop\PowerShellSecure.csv -Delimiter ";"
$change_pass = @{"true"=1;"false"=0}
foreach($user in $users){
    $fullname = $user.firstname + " " + $user.lastname
    $username = $user.username
    $lp = Get-Credential -Message "Entrer vos informations d'identification" -UserName $username
    $password = $lp.password
    if(Get-ADUser -F {SamAccountName -eq $username})
    {
        Write-Warning "Le compte existe déjà"
    }
    else 
    {
        try 
        {
        New-ADUser `
            -Name $fullname `
            -GivenName $user.firstname `
            -Surname $user.lastname `
            -SamAccountName $user.username `
            -DisplayName $fullname  `
            -Department $user.departement `
            -AccountPassword $password `
            -Path $user.ou `
            -Enabled 1 `
            -ChangePasswordAtLogon $change_pass[$user.ChangePWlogon]  
    
        }
        catch
        {
            Write-Host "Erreur !!!" -ForegroundColor Red
        }
    }
}