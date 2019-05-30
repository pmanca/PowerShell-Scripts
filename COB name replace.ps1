cls
$InputLocation = "C:\COB images\test\"

$files = Get-ChildItem -path 
$InpuitLocation

foreach($file in $files){
    
    $type = "BB-"

   
    $name = $InputLocation + $type + $file.Name
 
    Write-Host $name

    Rename-Item $file.FullName $name 
 
    

}