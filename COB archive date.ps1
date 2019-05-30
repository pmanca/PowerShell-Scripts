#This program is for COB and to figure out what volumes have been archived/when they were archived and if that was 30 days ago.  
cls
$file = gci "C:\test\old\COB Birth records  logging without note.bdf"
$logFile = "C:\test\archiveDate.txt"
$pattern = "^.*\|.*\|.*\|.*\|.*\|.*\|.*\|.*\|((\d{1,2})/(\d{1,2})/\d{4})\|(.*)\|.*\|.*\|$"
$lineCount = 0

$total = 0
[int]$dateMonth = Get-Date -UFormat "%m"
[int]$dateDay = Get-Date -UFormat "%d"


$totalDaysFromToday = 0
[array]$month=(31,28,31,30,31,30,31,31,30,31,30,31)

for($i = 0; $i -lt $dateMonth; $i++){
    
    $total += $month[$i]


}
$totalDaysFromToday += $total + $dateDay

function LogWrite{
    
    param([string]$logstring)

    Add-Content -value $logstring -path $logFile

}
LogWrite "Archive Date - Volume Year"
Get-Content $file|



    ForEach-Object{
        $lineCount++
        $totalDays = 0
        $total = 0
        if($lineCount -gt 1){
            if($_ -match $pattern){
                $archiveDate = $Matches[1]
                $volumeYear = $Matches[4]
                [int]$month2 = $Matches[2]
                [int]$day = $Matches[3]
                if("$archiveDate - $volumeYear" -ne $temp){
                    
                    for($i = 0; $i -lt $month2; $i++){
    
                        $total += $month[$i]


                    }
                   
                    $totalDays += $total + $day
                    $diffDays = $totalDaysFromToday - $totalDays
                    if($diffDays -lt 30 -and $diffDays -gt 0){
                        LogWrite "$archiveDate - $volumeYear - Has not Expired Yet"
                    }else{
                          LogWrite "$archiveDate - $volumeYear"
                    }
                } 
                $temp = "$archiveDate - $volumeYear"
            }else{
                LogWrite "fail"
            }
    
        }
    
 
    
    
    
    }