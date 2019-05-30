cls

$files = gci -path "C:\test\test2\" -filter "*.bdf"

foreach($file in $files){

   (Get-Content $file.FullName) | Foreach-Object {$_ -replace "`"", ""} | Set-Content $file.FullName

}