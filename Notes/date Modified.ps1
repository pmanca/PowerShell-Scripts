#Program to remove any files that are older then two weeks old 

$fileNames=@()
$fileNames = Get-ChildItem "\\lynx2\Waterworks\Excel Based Invoices\test" -Filter "*.pd_"| Where{$_.LastWriteTime -lt (Get-Date).AddDays(14)}


 Write-Host $fileNames

 foreach($file in $fileNames)
{
    Remove-Item -path $file.FullName
}