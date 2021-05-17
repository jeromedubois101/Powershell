$noms = Get-Content -Path .\noms.txt
foreach($nom in $noms)
{
New-Item -Path . -Name $nom -ItemType "directory"
}
# New-Item $noms -Type Directory --> Une seule ligne crée tous les répertoires