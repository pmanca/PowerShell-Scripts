cls
Exit-PSSession 
New-PSSession -ComputerName vm912test
Enter-PSSession -ComputerName vm912test -Credential sceris\pmanca 
Invoke-Command -Computername vm912test -ScriptBlock {Start-Process "calc.exe" -wait}

Get-PSSession