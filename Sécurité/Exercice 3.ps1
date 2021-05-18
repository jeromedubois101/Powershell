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
foreach($user in $users){
    $fullname = $user.firstname + " " + $user.lastname
    $lp = Get-Credential -Message "Entrer vos informations d'identification" -UserName $user.username
    $password = $lp.password
    if($user.ChangePWlogon -eq "true"){
        New-ADUser -Name $fullname -GivenName $user.firstname -Surname $user.lastname -SamAccountName $user.username -Department $user.departement -AccountPassword $password -Path $user.ou -Enabled 1 -ChangePasswordAtLogon 1
    }
    else {
        New-ADUser -Name $fullname -GivenName $user.firstname -Surname $user.lastname -SamAccountName $user.username -Department $user.departement -AccountPassword $password -Path $user.ou -Enabled 1 
    }
}