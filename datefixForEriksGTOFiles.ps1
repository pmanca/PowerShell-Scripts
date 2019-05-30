cls
$files = gci "C:\test\datefix\test1.txt"
$invalidDates = @("2080","2081","2082","2083","2084","2085","2086","2087","2088","2089","2090","2091","2092","2093","2094","2095","2096","2097","2098","2099")
$outputFile = "C:\test\datefix\output.txt"
foreach($file in $files){
    Write-Host $file.FullName

    Get-Content $file.FullName|

    foreach-object{
        #Write-Host $_
        $found = $false
        for($i = 0; $i -lt $invalidDates.Length; $i++){

            if($_ -match ".*"+$invalidDates[$i]+".*"){
               # Write-Host "match"
                $temp = $_ -replace $invalidDates[$i], "2079"
                Add-Content -Path $outputFile -Value $temp
                $found = $true
            }
            
        }
        if($found -eq $false){
            Add-Content -path $outputFile -Value $_
        }
    }

        $holdFileName = $file.Name
        Remove-Item -Path $file.FullName
        Rename-Item -path $outputFile -NewName $holdFileName



}