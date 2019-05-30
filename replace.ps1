cls
$InpuitLocation = "C:\COB images\1930 v1\"

$files = Get-ChildItem -path $InpuitLocation

foreach($file in $files){
    

   $name = $file.FullName
    
    $name = $name -replace "CR2_", "CR2" 

    Rename-Item $file.FullName $name 
 


}