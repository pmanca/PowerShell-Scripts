function Release-Ref ($ref) { 
([System.Runtime.InteropServices.Marshal]::ReleaseComObject( 
[System.__ComObject]$ref) -gt 0) 
[System.GC]::Collect() 
[System.GC]::WaitForPendingFinalizers() 
} 
$objExcel = new-object -comobject excel.application 
$objExcel.Visible = $False 
$objWorkbook = $objExcel.Workbooks.Open("C:\test\flag for errors\CoB%5FBirth%5FRecords.xls")
$objWorksheet = $objWorkbook.Worksheets.Item(1) 
[void]$objWorksheet.Cells.Item(1, 1).EntireRow.Delete() # Delete the first row
$objRange = $objWorksheet.UsedRange 
$objRange2 = $objworksheet.Range("E1") 
[void] $objRange.Sort($objRange2)


$a = Release-Ref($objWorksheet) 
$a = Release-Ref($objWorkbook) 
$a = Release-Ref($objExcel) 






#also saving as a csv and sorting in one


foreach($file in $files){
write-host $file

$xlCSV = 6
$CSVfilename = [io.path]::ChangeExtension($file.FullName,"csv")
$Excel = New-Object -comobject Excel.Application
$Excel.Visible = $False
$Excel.displayalerts=$False
$Workbook = $Excel.Workbooks.Open($file.FullName)
$objWorksheet = $Workbook.Worksheets.Item(1) 
[void]$objWorksheet.Cells.Item(1, 1).EntireRow.Delete() # Delete the first row
$objRange = $objWorksheet.UsedRange 
$objRange2 = $objworksheet.Range("E1") 
[void] $objRange.Sort($objRange2) 

$Workbook.SaveAs($CSVfilename,$xlCSV)
$Excel.Quit()
 Write-Host $CSVfilename

}