cls

$InputLocation = "C:\test\test\"


$files = Get-ChildItem -path $InputLocation







foreach($file in $files){
    

   $name = $file.BaseName.Substring(3,5)
    
    $name =  $name + ".CR2"

    Rename-Item $file.FullName $name


}
