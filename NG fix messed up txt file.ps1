$file = "C:\test\Test Bdfs\book1.txt"
$Outputfile = "C:\test\Test Bdfs\book2.txt"
$pattern = "^(.*\|.*\|)(.*)(\|\d{5}\|.*\|)$"
$lineCount = 0
$tempSplit = ""
Get-Content $file|

ForEach-Object{
    $lineCount++
    if($_ -match $pattern){
        Write-Host "found on line" $lineCount "bad area is " $Matches[1] " " $Matches[2] " " $Matches[3]
        $temp = $Matches[2] -replace ",", "|"
        $fullTemp = $Matches[1] + $temp + $Matches[3]
         Add-Content -Path $Outputfile -Value $fullTemp
    }else{
        Add-Content -Path $Outputfile -Value $_
    }
}