$texte = Read-Host "Entrez votre texte"
$texte = [string]$texte #Ou fonction $texte.tostring()
$texte_inverse = ""
$words = -split $texte #Ou fonction $texte.Split(" ")
foreach($word in $words) 
{
    $mot_inverse = ""
    for($i=0; $i -lt $word.length; $i++)
    {
        $mot_inverse += $word[-$i - 1]
    }
    $texte_inverse += $mot_inverse + " "
}
Write-Host $texte_inverse -ForegroundColor Green