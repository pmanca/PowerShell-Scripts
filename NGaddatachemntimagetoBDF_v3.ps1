#Known bug for last line of files. will give you an attachment that might be the first line of the next txt file.  


cls
$outputFile = "\\lynx2\NGTraveFix\Test Bdfs\output.txt"
$images = gci "\\lynx2\NGTraveFix\Original Images\"
$BDFs  = gci -path "\\lynx2\NGTraveFix\Test Bdfs\" -Filter "*.txt"
$imagePathPattern = "^\\\\lynx2\\Customers\\NationalGuard-TrainingOrders\\AnyDOC_Output\\Images\\(\d*).tif.*$"
$imageArray = @()
$imageArrayName=@()
foreach($image in $images){
            Write-Host $image
            $bdfName = [int]$image.BaseName
            $imageArray += $bdfName
            $imageArrayName += $image.FullName
        }

foreach($file in $BDFS){
        write-host $file
        $lineCount = 0  
        
        $lines = Get-Content -path $file.FullName|
        
        foreach-object{
            
            
                $processed = $false
                if($_ -match $imagePathPattern){
                    if($lineCount -ne 0){

                        if([int]$Matches[1] - 1 -ne $oldMatch){
                            for($i = 0; $i -lt $imageArray.length; $i++){
                                if([int]$Matches[1] - 1 -eq $imageArray[$i] -and $oldMatch -ne [int]$Matches[1] -1){
                                    if($processed -eq $false){
                                        $imagePathName = $imageArrayName[$i]
                                        [string]$imagePathName += "|"
                                        Add-Content -value $imagePathName -path $outputFile
                                        Add-Content -value $_ -path $outputFile
                                        $processed = $true
                                    }
                                }#end if
                    
            
                            }#end for loop
                            if($processed -eq $false){
                                Add-Content -value $_ -path $outputFile
                                $processed = $true
                            }#end if to processed equals false
                         
                        }else{#end if to matches-1 ne old
                            Add-Content -value $_ -Path $outputFile
                        }
                        }else{#end if to linecount ne 0
                            Add-Content -value $_ -path $outputFile
                            $processed = $true
            
                        }
                           $oldMatch = $Matches[1]
                    }#end if to match imagepathpattern
            
            $lineCount++
         }#end foreach-object loop
                $processed = $false
            
                for($i = 0; $i -lt $imageArray.length; $i++){#This group of code is to run for the last line of the file to do the same as above.  
                    if([int]$oldMatch + 1 -eq $imageArray[$i]){
                        
                        $imagePathName = $imageArrayName[$i]
                        [string]$imagePathName += "|"
                        Add-Content -value $imagePathName -path $outputFile
                        $processed = $true
                    }#end if to old match +1
                    
            
                }#end for loop to -lt
                if($processed -eq $false){
                        Add-Content -value $_ -path $outputFile
                        $processed = $true
                }#end if to processed equals false
        
        
        
                
        $holdFileName = $file.Name
        Remove-Item -Path $file.FullName
        Rename-Item -path $outputFile -NewName $holdFileName

           
}