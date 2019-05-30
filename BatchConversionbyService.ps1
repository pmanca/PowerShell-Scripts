cls
#This script is to convert a bch file from batch level 5 to 4. 
#It was set up to be run by a task scheduler task every 30 minuetes and to convert any file left in the directory below
########################################################################################
$files = gci "\\lynx2\C$\Customers\BatCH convert\" -Filter "*.BCH"
$pattern = "^\d \d \d \d$"


foreach($file in $files){
    $outputFile = $file.FullName 
    $outputFile = $outputFile -replace ".BCH", ".HOLD"
    $count = 0

    Get-Content -Path $file.FullName |

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
    Remove-Item -Path $file.FullName
    Rename-Item -Path $outputFile -NewName $file.FullName
    
}