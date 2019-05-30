#Start of a batch is anything that starts with an N:.* and then
# the second line will say F: expense3 instead of attachement
#
#
#Powershell Script to break up GTO files
#Peter Manca 9/9/2015

cls
$pattern = "N:.*"
$pattern2 = "F:expense3"

function GTOWrite($tString, $tOutputFile){
    Add-Content -Value $tString -Path $tOutputFile
}


$file = "C:\Users\pmanca\Desktop\00103162.gto"
$homeDirectory = "C:\test\TRC\"
$count = 0
$batchFound = $false
Get-Content $file | ForEach-Object{
    
    if($linehold -match $pattern -and $_ -match $pattern2){
        write-host "Found Batch"
        $batchFound = $true
        $count++
        GTOWrite -tString $linehold -tOutputFile "$homeDirectory\$count.gto"
        
    }elseif($batchFound){
        GTOWrite -tString $linehold -tOutputFile "$homeDirectory\$count.gto"
    }

   









    $linehold = $_
}