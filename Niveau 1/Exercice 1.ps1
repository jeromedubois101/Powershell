Get-Alias dir
Get-Alias ls

$répertoire = Get-ChildItem
$répertoire
$répertoire[0]

$répertoire | Get-Member

$répertoire[0].LastWriteTime
$répertoire[0].root
$répertoire[0].GetAccessControl()