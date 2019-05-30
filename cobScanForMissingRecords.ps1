cls
$file = "M:\COB\completeListFrom92514.txt"
$logfile = "C:\test\logFIleFOrCOB2.txt"
$pattern = "^(.*)`t(.*)`t(.*)$"
$lines = Get-Content $file
$tempRecord = 0
function LogWrite{

    param([string]$logstring)

    Add-Content -Value $logstring -path $logfile

}
foreach($line in $lines){
    if($line -match $pattern -and $Matches[1] -ne "NULL"){
    
        if($Matches[1] -eq $tempRecord){
        }elseif($Matches[1] - $tempRecord -eq 1){
        }elseif($Matches[2] -eq $tempYear -and $Matches[3] -eq $tempType){
            LogWrite $Matches[0]
            Write-Host $Matches[0]
        }




        $tempRecord = $Matches[1]
        $tempYear = $Matches[2]
        $tempType = $Matches[3]
        Write-Host $Matches[0]
    }
}