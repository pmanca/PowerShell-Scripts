cls
$logFile = "C:\test\output2.txt"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}
$logFile2 = "C:\test\output04162014.txt"
Function LogWrite2
{
   Param ([string]$logstring)

   Add-content $Logfile2 -value $logstring
}

LogWrite "ArchivedDate|YearofVolume|RecordType|RecordNumber|UDI|wrong|correct|errorCountLine|DocumentID"
LogWrite "---------------------------------------------------------------------------------"
$file = "C:\test\COB Birth records  logging without note.bdf"#input without notes
$pattern = "^.*\|COB Reviewed\|.*$"
$pattern2 = "^.*\|DocSecID\|.*$"
$pattern3 = "^(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|$"



$errorCountTotal = 0
$linecount = 0
$line2Count = 0
Get-Content $file|


    ForEach-Object{
    $errorCountLine = 0
    $linecount++
    $transposition = $false
       if($_ -match $pattern){
  
         
        }elseif($_ -match $pattern2){

           
            

        }elseif($_ -match $pattern3 -and $linecount -gt 1){
        $line2Count++
           
          
           

                if($matches[6].Length -eq $matches[7].length){
                    $correct = $matches[6]
                    $wrong = $matches[7]
                    $documentID = $matches[3]
                    $UDI = $matches[8]
                    $ArchivedDate = $matches[9]
                    $YearofVolume = $matches[10]
                    $RecordType = $matches[11]
                    $RecordNumber = $matches[12]
                    $a = [char[]]$Matches[6]
                    $b = [char[]]$matches[7]
                    

                 
                                
                    $errorCountLine += (@(Compare-Object $a $b -SyncWindow 0).count /2)
                    
                    $errorCountTotal += $errorCountLine
                   # Write-Host $matches[6] " - " $matches[7] " - " $errorCountLine " - " $linecount
                   # Write-Host $errorCountTotal
                   LogWrite "$ArchivedDate|$YearofVolume|$RecordType|$RecordNumber|$UDI|$wrong|$correct|$errorCountLine|$documentID|"
                }else{
                 $correct = $matches[6]
                    $wrong = $matches[7]
                    $documentID = $matches[3]
                    $UDI = $matches[8]
                    $ArchivedDate = $matches[9]
                    $YearofVolume = $matches[10]
                    $RecordType = $matches[11]
                    $RecordNumber = $matches[12]
                    $a = [char[]]$Matches[6]
                    $b = [char[]]$matches[7]
                    
                    $pattern4 = "(\d{1,2})/(\d{1,2})/(\d{4}) (0:00)"
                    $pattern5 = "(\d{4})(\d{1,2})(\d{1,2})"
                    if($wrong -match $pattern4){
                      $month = $matches[1]
                      $day = $matches[2]
                      $year = $matches[3]
                        if($month -match "\d{1}"){
                        
                            $newMonth = "0$month"
                            
                        }if($day -match "\d{1}"){
                       
                            $newDay = "0$day"
                            
                        }
                        $b = $newMonth+"/"+$newDay+"/"+$year
                        
                    }
                    if($correct -match $pattern5){
                        $a = $matches[2]+"/"+$matches[3]+"/"+$matches[1]
                    }
                    
                    
                    $diffL = [math]::Abs($Matches[7].Length - $Matches[6].Length)
                    if($wrong -eq "----"){
                        $errorCountLine += $correct.Length
                    }elseif($correct -match "\d{8}"){
                    
                        $errorCountLine += (@(Compare-Object $a $b).count)
                    
                    
                    }else{
                        $errorCountLine += (((@(Compare-Object $a $b).count-$diffL) /2) + $diffL)
                    }
                    $errorCountTotal += $errorCountLine
                   
                   # Write-Host $matches[6] " - " $matches[7] " - " $errorCountLine " - " $linecount
                   
                    LogWrite "$ArchivedDate|$YearofVolume|$RecordType|$RecordNumber|$UDI|$wrong|$correct|$errorCountLine|$documentID|"#$linecount"
                    #Write-Host $errorCountTotal

                }

           
        }



    }

    Write-Host $linecount "-" $line2Count #number of lines that the program looks at.  passes through pattern3.
    LogWrite `n
    LogWrite "The total number of errors is $errorCountTotal"


    $secondInput = "C:\test\COB Birth records  logging with note.bdf"#input with the notes
    $pattern6 = "^(.*)\|(.*)\|(\d*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|$"
    $pattern7 = "^.*\|\d{4,5}\|.*\|(\d*)\|.*\|.*\|.*\|.*\|(\d*)\|$"
    $temp = ""
    LogWrite2 "ArchivedDate|YearofVolume|RecordType|RecordNumber|UDI|wrong|correct|errorCountLine|DocumentID|Notes"
    LogWrite2 "----------------------------------------------------------------------------------------------------"    
Get-Content $secondInput|
    

    ForEach-Object{
   # Write-Host $_
        if($_ -match $pattern6){
            $docID = $Matches[3]
            $notes = $Matches[13]
           
            Get-Content $logFile|
                ForEach-Object{
                
                    if($_ -match $pattern7){
                    Write-Host "0"
                        $documentID = $Matches[2]
                        #Write-Host $documentID "-" $docID
                        if($documentID -eq $docID){
                             Write-Host "1"
                           if("$_$notes|" -ne $temp){
                           write-host "2"
                                LogWrite2 "$_$notes|"
                            }
                            $temp = "$_$notes|"
                        }
                    }
                    
                    
                }
              
        }

    }

                 LogWrite2 `n
                LogWrite2 "The total number of errors is $errorCountTotal"