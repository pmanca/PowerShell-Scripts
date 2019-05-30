cls
#This program takes the cob query from COB with out notes and churns out a file that consists of the fixed UDI aling with the record number
$logFile#set below dynamically based off year.  
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}


$file = "C:\test\old\COB Birth records  logging without note.bdf"

$pattern2 = ".*\|(.*)\|(.*)\|(.*)\|\d{1,2}/\d{1,2}/\d{4}\|(\d{5})\|.*\|(\d*)\|$"
$linecount = 0
Get-Content $file|




ForEach-Object{

    if($_ -match $pattern2){
        $linecount++
        [int]$year = $Matches[4]
        $logFile = "C:\test\$year.bdf"
        write-host $linecount " - " $Matches[1] " - " $Matches[2] " - " $Matches[3] " - " $Matches[5]
        [string]$temp1 = $Matches[2]
        if($temp1 -eq "NULL" -or $temp1 -eq "Y" -or $temp1 -eq "`""){
          
        }else{
             $temp = $Matches[1] + "|" + $Matches[2] + "|" + $Matches[3] + "|" + $Matches[5]
            LogWrite $temp
        }
    }

}