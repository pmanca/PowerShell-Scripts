cls
#00000000092-00001
#$testBatch = "612748-01"
$outputFile = "C:\test\whaaaat.txt"
$file = "C:\test\new  2.txt"
$count = 0
function padLeft([string]$testBatch){
    [array]$arr = $testBatch.Split('-') 
    [string]$left = $arr[0]
    [string]$right = $arr[1]

    $left = $left.padLeft(11,"0")
    $right = $right.PadLeft(5,"0")
    $finish = "$left-$right"
    
    Write-Host $finish
    Add-Content -path $outputFile -Value $finish
}

Add-Content -path $outputFile -Value "Batch_Name"


Get-Content $file |

ForEach-Object{
    if($count -ne 0){
        padLeft -testBatch $_
    }
    $count++
}