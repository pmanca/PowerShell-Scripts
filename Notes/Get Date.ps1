cls
$input = "C:\test\"

$files = gci $input -Recurse

#in oreder for the Get-Date commandlet to output a string you need to either you the -format or -uformat parameter
#g value to the -format parameter will returna  short general datetime. ex. 4/10/2014 10:30 AM
#after saved as string in order to save it as a file name you must remove the forward slashes and the colon.  

$date = Get-Date -Format g
$date = $date -replace "/", "."
$date = $date -replace ":"," "
$files | Out-File "C:\test\$date.txt"
Write-Host $date




### better wat to do it as of 2/27/15  [DateTime]::Today.AddDays(-1)  returns yesterdays date and just a 00:00 for a time no english.  better for sql queries