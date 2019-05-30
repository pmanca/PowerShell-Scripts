cls
Start-Transcript -Path "C:\test\G Drive Output.txt"
$folders = gci -Path "C:\x - Copy"
$outputParentFolder = "C:\x - Copy\FirstPass\"
$output2ParentFolder = "C:\x - Copy\SecondPass\"
$output3ParentFolder = "C:\x - Copy\ThirdPass\"
$output4ParentFolder = "C:\x - Copy\FourthPass\"
$output5ParentFolder = "C:\x - Copy\FifthPass\"
$output6ParentFolder = "C:\x - Copy\SisthPass\"
$output7ParentFolder = "C:\x - Copy\SeventhPass\"
$output8ParentFolder = "C:\x - Copy\EigthPass\"
$outputText = "$outputParentFolder\BDFOutput.txt"
$output2Text = "$output2ParentFolder\BDFOutput.txt"
$output3Text = "$output3ParentFolder\BDFOutput.txt"
$output4Text = "$output4ParentFolder\BDFOutput.txt"
$output5Text = "$output5ParentFolder\BDFOutput.txt"
$output6Text = "$output6ParentFolder\BDFOutput.txt"
$output7Text = "$output7ParentFolder\BDFOutput.txt"
$output8Text = "$output8ParentFolder\BDFOutput.txt"
if(!(Test-Path $outputParentFolder)){New-Item -ItemType directory -Path $outputParentFolder}
if(!(Test-Path $output2ParentFolder)){New-Item -ItemType directory -Path $output2ParentFolder}
if(!(Test-Path $output3ParentFolder)){New-Item -ItemType directory -Path $output3ParentFolder}
if(!(Test-Path $output4ParentFolder)){New-Item -ItemType directory -Path $output4ParentFolder}
if(!(Test-Path $output5ParentFolder)){New-Item -ItemType directory -Path $output5ParentFolder}
if(!(Test-Path $output6ParentFolder)){New-Item -ItemType directory -Path $output6ParentFolder}
if(!(Test-Path $output7ParentFolder)){New-Item -ItemType directory -Path $output7ParentFolder}
if(!(Test-Path $output8ParentFolder)){New-Item -ItemType directory -Path $output8ParentFolder}
$custNum = ""
foreach($folder in $folders){#start of foreach folder
    $subFolder = $folder.FullName
    
    Write-Host $subFolder
    $custNum = gci "$subFolder\CREDIT FOLDER\"



    if(!(Test-Path -Path "$outputParentFolder\CREDIT FOLDER\$custNUM")){#first check
        

            Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
            Add-Content -path $outputText -Value $_
        
        
        }

        
        Remove-Item "$subFolder\MSBLog.bdf"
        $subFolderGCI = gci $subFolder
        foreach($subsubFolder in $subFolderGCI){
            Write-Host $subsubFolder
            Copy-Item -Path $subsubFolder.FullName -Destination "$outputParentFolder" -Recurse -Force
        }

        
    
    }else{#If Fail first check
    
        Write-Host "Already there"
        if(!(Test-Path -Path "$output2ParentFolder\CREDIT FOLDER\$custNUM")){#second check
        

            Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                Add-Content -path $output2Text -Value $_
        
        
            }



            Remove-Item "$subFolder\MSBLog.bdf"
            $subFolderGCI = gci $subFolder
            foreach($subsubFolder in $subFolderGCI){
                Write-Host $subsubFolder
                Copy-Item -Path $subsubFolder.FullName -Destination "$output2ParentFolder" -Recurse -Force
            }
        }else{#if fail second check
            Write-Host "Already there twice"
            if(!(Test-Path -Path "$output3ParentFolder\CREDIT FOLDER\$custNUM")){#third check
        

                    Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                    Add-Content -path $output3Text -Value $_
        
        
                }



                Remove-Item "$subFolder\MSBLog.bdf"
                $subFolderGCI = gci $subFolder
                foreach($subsubFolder in $subFolderGCI){
                    Write-Host $subsubFolder
                    Copy-Item -Path $subsubFolder.FullName -Destination "$output3ParentFolder" -Recurse -Force
                }

                }else{#if fail third check



                    Write-Host "Already there thrice"
                    if(!(Test-Path -Path "$output4ParentFolder\CREDIT FOLDER\$custNUM")){#fourth check
        

                        Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                            Add-Content -path $output4Text -Value $_
        
        
                        }



                        Remove-Item "$subFolder\MSBLog.bdf"
                        $subFolderGCI = gci $subFolder
                        foreach($subsubFolder in $subFolderGCI){
                            Write-Host $subsubFolder
                            Copy-Item -Path $subsubFolder.FullName -Destination "$output4ParentFolder" -Recurse -Force
                        }

                   }else{
                     Write-Host "Already there Four Ttmes"
                     if(!(Test-Path -Path "$output5ParentFolder\CREDIT FOLDER\$custNUM")){#fifth check
        

                        Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                            Add-Content -path $output5Text -Value $_
        
        
                        }



                        Remove-Item "$subFolder\MSBLog.bdf"
                        $subFolderGCI = gci $subFolder
                        foreach($subsubFolder in $subFolderGCI){
                            Write-Host $subsubFolder
                            Copy-Item -Path $subsubFolder.FullName -Destination "$output5ParentFolder" -Recurse -Force
                        }

                   }else{
                         Write-Host "Already there five times"
                         if(!(Test-Path -Path "$output6ParentFolder\CREDIT FOLDER\$custNUM")){#sixth check
        

                            Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                                Add-Content -path $output6Text -Value $_
        
        
                            }



                            Remove-Item "$subFolder\MSBLog.bdf"
                            $subFolderGCI = gci $subFolder
                            foreach($subsubFolder in $subFolderGCI){
                                Write-Host $subsubFolder
                                Copy-Item -Path $subsubFolder.FullName -Destination "$output6ParentFolder" -Recurse -Force
                            }

                       }else{
                                         Write-Host "Already there Six Times"
                            if(!(Test-Path -Path "$output7ParentFolder\CREDIT FOLDER\$custNUM")){#Seventh check
        

                                Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                                    Add-Content -path $output7Text -Value $_
        
        
                                }



                                Remove-Item "$subFolder\MSBLog.bdf"
                                $subFolderGCI = gci $subFolder
                                foreach($subsubFolder in $subFolderGCI){
                                    Write-Host $subsubFolder
                                    Copy-Item -Path $subsubFolder.FullName -Destination "$output7ParentFolder" -Recurse -Force
                                }

                             }else{
                           
                                         Write-Host "Already there Seven TImes"
                                        if(!(Test-Path -Path "$output8ParentFolder\CREDIT FOLDER\$custNUM")){#Eigth check
        

                                            Get-Content "$subFolder\MSBLog.bdf" | ForEach-Object{
        
                                                Add-Content -path $output8Text -Value $_
        
        
                                            }



                                            Remove-Item "$subFolder\MSBLog.bdf"
                                            $subFolderGCI = gci $subFolder
                                            foreach($subsubFolder in $subFolderGCI){
                                                Write-Host $subsubFolder
                                                Copy-Item -Path $subsubFolder.FullName -Destination "$output8ParentFolder" -Recurse -Force
                                            }

                                       }
                           
                           
                           
                           
                           }#end of seventh check else
                       
                       
                       
                       
                       }#end of sixth Check else
                   }#end of fifth check else
                   
                   
                   
                   }#ENd of fourch check else
            }#end of third check else



        }

    }



}
Stop-Transcript
