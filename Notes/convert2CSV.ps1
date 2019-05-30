$xlCSV = 6
$Excelfilename = "C:\Users\pmanca.SCERIS\Documents\book1.xlsx"
$CSVfilename = "C:\file.csv"
$Excel = New-Object -comobject Excel.Application
$Excel.Visible = $False
$Excel.displayalerts=$False
$Workbook = $Excel.Workbooks.Open($ExcelFileName)
$Workbook.SaveAs($CSVfilename,$xlCSV)
$Excel.Quit()




