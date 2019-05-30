function LogWrite{

    param([string]$logstring)

    Add-Content -Value $logstring -Path $output


}
$lineCount = 0
$lineCount2 = 0

$file1 = gci "M:\COB\Compare1.txt"
$file2 = gci "M:\COB\Compare2.txt"
$output = "C:\test\testoutputCOB.txt"

$lines1 = Get-Content $file1
$lines2 = Get-Content $file2


ForEach($line in $lines1){
    $lineCount++
    $tempLine = $line
    $count=0

    foreach($line2 in $lines2){
        $lineCount2++
        $tempLine2 = $line2
        
            
            if($tempLine -eq $tempLine2){
               $count++
            }
        

    
        
    
    }
    if($count -eq 0){
         LogWrite "$lineCount  -  $tempLine"
         #Write-Host "hey"
    }


}
