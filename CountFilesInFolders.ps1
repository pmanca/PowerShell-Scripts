$folders = gci "E:\Peter-to process - Copy\x"



foreach($folder in $folders){
    
    $subfolder = gci $folder.FullName

        if($subfolder.Count -gt 3){
        
            Add-Content -path "C:\test\countOutput.txt" -Value $folder
        
        
        }

    

}