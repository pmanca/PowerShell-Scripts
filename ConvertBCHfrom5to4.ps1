$file = "O:\pmanca\CHA TESTING\LYNX 2\484-72test2\484-72test2.BCH"
$pattern = "^\d \d \d \d$"
$outputFile = "O:\pmanca\lynx2Dump.bch"
$count = 0

Get-Content -Path $file |

foreach-object{
    $count++
    if($count -eq 1){
        Add-Content -Value "4" -Path $outputFile
    }elseif($_ -match $pattern){
        Add-Content -Value $_.ToString().Substring(0,5)    -Path $outputFile
    }else{
        Add-Content -Value $_ -Path $outputFile
    }
}