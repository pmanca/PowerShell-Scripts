$files = gci "F:\ScerIS Customers\Pioneer\Files from Pioneer\*.zip"
$pioneerDest = "\\lynx2\Customers\Pioneer\ConcurTemp Files"
$OutputDirectory = "\\lynx2\Customers\Pioneer\ConcurTemp Files\Processed"
#ReportID, RecordID, EmployeeID
function Expand-ZIPFile($file, $destination)
{
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items())
    {
        $shell.Namespace($destination).copyhere($item)
    }
}
if(!(Test-Path -Path "$pioneerDest\Processed")){
    New-Item -Path "$pioneerDest\Processed" -Type directory
}

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
#Creates Error Folder
if(!(Test-Path -Path "$pioneerDest\Error")){
    write-host "$pioneerDest\Error"
    New-Item -Path "$pioneerDest\Error" -Type directory
}
#copies files from brick
foreach($file in $files){
    Write-Host $file.FullName
    Copy-Item -Path $file.FullName -Destination $pioneerDest
    $zipName = $file.Name
    Write-Host "$pioneerDest\$zipName"
    Expand-ZIPFile -file "$pioneerDest\$zipName" -destination $pioneerDest
    Remove-Item -Path "$pioneerDest\$zipName"

}


$filesCSV = gci $pioneerDest -Filter "*.csv"
[int]$count = 0
foreach($file2 in $filesCSV){
    
    Get-Content $file2.FullName |
    ForEach-Object{
        $count++
    }
    
    $arr = Import-Csv -Path $file2.FullName -Header "ReportID","RecordID","EmployeeID"
    if($arr[0].ReportID -ne $count){
        Write-Host "Issue with count"
    }
}






Write-Host "COUNT: " $count
$PDFList = gci -Path $pioneerDest -Filter "*.pdf"
Write-Host "PDFS: " $PDFList.Count
$pioneerDestFiles = gci -Path $pioneerDest -Include "*.pdf", "*.csv"
if($count -gt $PDFList.Count){
    
    foreach($f in $pioneerDestFiles){
        
        Move-Item -Path $f.FullName -Destination "$pioneerDest\Error" -force
        
    }
    
    exit
}
$InputDirectory = $pioneerDest
for ($j=0; $j -lt $PDFList.count; $j++) {   
    #Each PDF will go into its own directory/batch 
    
    
    #Create a variable with only the file name
    $FileName = $PDFList[$j] -replace(".pdf",'')


    #Variable of the full path to the current PDF
	$InputPath = $InputDirectory + '\' + $PDFList[$j]
		
	
	#Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	$OutputFullDirectory = $OutputDirectory + '\'+ $FileName + '.tif'
	 
	#Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	&'C:\Program Files\gs\gs9.16\bin\gswin64c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
    #Increment the counter for the loop
    $DocCounter = $j + 1

    #Rename the current pdf so that it isn't processed again.
	$RenamePath = $PdfList[$j] -replace("pdf", "pd_")
    Rename-Item $InputPath $RenamePath

} 






foreach($file in $filesCSV){
    
    $bdfFile = [io.path]::ChangeExtension($file.FullName, "bdf")
    
   Get-Content $file.FullName | Convert-Delimiter "," "|" | Set-Content $bdfFile

   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"`"", "qqqq"} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"", ""} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "qqqq", "`""} | Set-Content $bdfFile
   Write-Host $bdfFile
   Move-Item $bdfFile -Destination "$pioneerDest\Processed"
   
}

