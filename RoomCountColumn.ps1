cls
#This is the second of the two scripts run to count the rooms and suites for Marriott for the year end billing
#the second first is called RoomCount
#this script takes the raw data and converts it into a column based file that can be easily imported into excel
#Peter Manca
$file  = "C:\test\roomcount.txt"
$newFile = "C:\test\roomCountColumn.txt"
$pattern = "^\w{5}$"
$patternRoom = "^\d*.*rooms$"
$patternSuite = "^\d*.*suites$"

Get-Content $file|
ForEach-Object{
    $temp = $_
 
    if($temp -match $patternSuite){
        $suiteHold = $_
        
    }elseif($temp -match $patternRoom){
        $roomHold = $_
    }elseif($temp -match $pattern){
        Add-Content -value "$marshaHold|$roomHold|$suiteHold" -path $newFile
       $suiteHold = ""
       $roomHold = ""
       $marshaHold = ""
       $marshaHold = $_
    }
    Write-Host $_



}