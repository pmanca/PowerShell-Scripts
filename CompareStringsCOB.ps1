cls
$logFile = "C:\test\output1.txt"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}


LogWrite "Time|DocumentID|Correct|Wrong|UDI|Number of Errors|Line Number"
LogWrite "------------------------------------------"
$file = "C:\test\test\Birth records evt logging.txt"
$pattern = "^(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(COB Reviewed)$"
$pattern2 = "^(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(DocSecID)$"
$pattern3 = "^(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)`t(.*)$"



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

           
            

        }elseif($_ -match $pattern3){
        $line2Count++
           


                if($matches[6].Length -eq $matches[7].length){
                    $correct = $matches[6]
                    $wrong = $matches[7]
                    $documentID = $matches[3]
                    $UDI = $matches[8]
                    $time = $matches[1]
                    $a = [char[]]$Matches[6]
                    $b = [char[]]$matches[7]
                    

                   # for($i = 0; $i -lt $a.Length; $i++){
                        
                       # for($x = 1; $x -lt $a.Length; $x++){
                           # if($a[$i] -eq $b[$i+$x] -and $a[$i+$x] -eq $b[$i]){
                             #   if($a[$i] -eq $a[$i+$x]){
                               # write-host "same letter"
                             #   }else{
                                    
                                   # $errorCountLine += 2
                                   
                               # }
                           # }

                       # }


                    #}





                    #Compare-Object $a $b |Format-List |Out-File "C:\test\test3.txt"
                                
                    $errorCountLine += (@(Compare-Object $a $b -SyncWindow 0).count /2)
                    
                    $errorCountTotal += $errorCountLine
                   # Write-Host $matches[6] " - " $matches[7] " - " $errorCountLine " - " $linecount
                   # Write-Host $errorCountTotal
                    LogWrite "$time|$documentID|$correct|$wrong|$UDI|$errorCountLine|$linecount"
                }else{
                    $correct = $matches[6]
                    $wrong = $matches[7]
                    $documentID = $matches[3]
                    $UDI = $matches[8]
                    $time = $matches[1]
                    $a = [char[]]$Matches[6]
                    $b = [char[]]$matches[7]
                    
                    $pattern4 = "(\d{1,2})/(\d{1,2})/(\d{4}) (12:00:00 AM)"
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
                   
                    LogWrite "$time|$documentID|$correct|$wrong|$UDI|$errorCountLine|$linecount"
                    #Write-Host $errorCountTotal

                }

           
        }



    }

    Write-Host $linecount "-" $line2Count #number of lines that the program looks at.  passes through pattern3.
    LogWrite `n
    LogWrite "The total number of errors is $errorCountTotal"

