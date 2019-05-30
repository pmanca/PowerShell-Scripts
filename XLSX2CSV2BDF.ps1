cls
Function Convert-Delimiter([regex]$from,[string]$to)
    {
       begin
       {
          $z = [char](222)
       }
       process
       {
          $_ = $_.Trim()
          $_ = $_ -replace "(?:`"((?:(?:[^`"]|`"`"))+)(?:`"$from|`"`$))|(?:$from)|(?:((?:.(?!$from))*.)(?:$from|`$))","$z`$1`$2$z$to"
          $_ = $_ -replace "$z(?:$to|$z)?`$","$z"
          $_ = $_ -replace "`"`"","`"" -replace "`"","`"`""
          $_ = $_ -replace "$z((?:[^$z`"](?!$to))+)$z($to|`$)","`$1`$2"
          $_ = $_ -replace "$z","`"" -replace "$z","`""
          $_
       }
    }
#$input = Read-Host "What folder to grab all the xls files"     
$files = gci "C:\test\test Bdfs\" -filter "*.xls*"


foreach($file in $files){
write-host $file

$xlCSV = 6
$CSVfilename = [io.path]::ChangeExtension($file.FullName,"csv")
$Excel = New-Object -comobject Excel.Application
$Excel.Visible = $False
$Excel.displayalerts=$False
$Workbook = $Excel.Workbooks.Open($file.FullName)
$Workbook.SaveAs($CSVfilename,$xlCSV)
$Excel.Quit()
 Write-Host $CSVfilename

}

$filesCSV = gci "C:\test\test Bdfs\" -filter "*.csv"


foreach($file in $filesCSV){

    $bdfFile = [io.path]::ChangeExtension($file.FullName, "bdf")
    
    Get-Content $file.FullName | Convert-Delimiter "," "|" | Set-Content $bdfFile

   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"`"", "qqqq"} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"", ""} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "qqqq", "`""} | Set-Content $bdfFile
   Write-Host $bdfFile
}


