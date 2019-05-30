cls
$outputFile = "C:\Test for Peter\Backup from Lynx2\AnyDoc_Output (Backup)\Archived\output.txt"
$images = gci "C:\Test for Peter\Backup from Lynx2\AnyDoc_Output (Backup)\Images\"
$BDFs  = gci -path "C:\Test for Peter\Backup from Lynx2\AnyDoc_Output (Backup)\Archived" -Filter "*.txt"
$imagePathPattern = "^\\\\lynx2\\Customers\\NationalGuard-TrainingOrders\\AnyDOC_Output\\Images\\(\d*).tif.*$"
$imageArray = @()
$imageArrayName=@()

foreach($file in $BDFS){
    
        foreach($image in $images){
            $bdfName = [int]$image.BaseName
            $imageArray += $bdfName
            $imageArrayName += $image.FullName
        }
        $lines = Get-Content -path $file.FullName|
        
        foreach-object{
            $processed = $false
            if($_ -match $imagePathPattern){
                for($i = 0; $i -lt $imageArray.length; $i++){
                    if([int]$Matches[1] - 1 -eq $imageArray[$i] -and $oldMatch -ne [int]$Matches[1] -1){
                        
                        $imagePathName = $imageArrayName[$i]
                        [string]$imagePathName += "|"
                        Add-Content -value $imagePathName -path $outputFile
                        Add-Content -value $_ -path $outputFile
                        $processed = $true
                    }
                    
            
                }
                if($processed -eq $false){
                        Add-Content -value $_ -path $outputFile
                        $processed = $true
                }
                $oldMatch = $Matches[1]
            }
         }
                $processed = $false
            
                for($i = 0; $i -lt $imageArray.length; $i++){
                    if([int]$oldMatch + 1 -eq $imageArray[$i]){
                        
                        $imagePathName = $imageArrayName[$i]
                        [string]$imagePathName += "|"
                        Add-Content -value $imagePathName -path $outputFile
                        $processed = $true
                    }
                    
            
                }
                if($processed -eq $false){
                        Add-Content -value $_ -path $outputFile
                        $processed = $true
                }
        
        
        
                
        $holdFileName = $file.Name
        Remove-Item -Path $file.FullName
        Rename-Item -path $outputFile -NewName $holdFileName

           
}