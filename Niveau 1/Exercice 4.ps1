$tab = Get-Process | ? {$_.ProcessName -eq "notepad"}
# $tab = Get-Process notepad
$tab.kill()
