#progamr to search and replace in files for Nation Guard payroll project
CLS

$patterntoReplace = "^(C:\\Test for Peter.*)(\\Images\\.*)$"
$files = gci -Path "C:\Test for Peter\Backup from Lynx2 - Copy - Copy\AnyDoc_Output (Backup)\TXT copy" -Filter "*.txt*"
$outputFile = "C:\Test for Peter\Backup from Lynx2 - Copy - Copy\AnyDoc_Output (Backup)\TXT copy\output.txt"



foreach($file in $files){
   
    Write-Host $file.FullName
    Get-Content $file.FullName|

    ForEach-Object{
        if($_ -match $patterntoReplace){
           # Write-Host $Matches[1]
           # $oldline = $Matches[1] -replace "\\","\\"
           ## Write-Host $oldline
            $temp = $_ -replace "C:\\Test for Peter\\Backup from Lynx2 - Copy - Copy\\AnyDoc_Output \(Backup\)", "\\lynx2\Customers\NationalGuard-TrainingOrders\AnyDOC_Output"
           # Write-Host $temp
            Add-Content -path $outputFile -Value $temp
        }else{
            Add-Content -path $outputFile -Value $_
        }
    
       # write-host $file.FullName
    
    
    }

        $holdFileName = $file.Name
        Remove-Item -Path $file.FullName
        Rename-Item -path $outputFile -NewName $holdFileName


}