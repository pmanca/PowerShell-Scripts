 cls

#Variable to hold current input directory 
$InputDirectory = 'C:\test\sample pdfs'
$InputPathFilter = $InputDirectory + '\*.pdf'

#Variable to hold current output directory
$OutputDirectory = 'C:\test\tif\'
$BDFOutputDirectory = "C:\test\tif\"

#Variable to hold the list of PDFs from the current input directory
$PDFList = @(gci $InputPathFilter | foreach {write-output $_.name})

#Check to verify output directory does not exist and then create the output directory
if ((Test-Path $OutputDirectory) -ne $TRUE) {
	New-Item $OutputDirectory -type directory
}

#Loop through list of PDF files to convert to TIF image files.
for ($j=0; $j -lt $PDFList.count; $j++) {   
    #Each PDF will go into its own directory/batch 
    
    
    #Create a variable with only the file name
    $FileName = $PDFList[$j] -replace(".pdf",'')

    
    #Create a variable of the full path
    #$OutputFullDirectory = $OutputDirectory  + $FileName
    
    #Create the subdirectory for the current PDF
    if ((Test-Path $OutputFullDirectory) -ne $TRUE) {
	New-Item $OutputFullDirectory -type directory
    }

    #Variable of the full path to the current PDF
	$InputPath = $InputDirectory + '\' + $PDFList[$j]
		
	
	#Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	$OutputFullDirectory = $OutputFullDirectory + '\'+ $FileName + "_" + "{0:D4}" -f + '1' + '%04d.tif' 
	 
	#Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	&'C:\Program Files\gs\gs9.14\bin\gswin64c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
    #Increment the counter for the loop
    $DocCounter = $j + 1

    #Rename the current pdf so that it isn't processed again.
	$RenamePath = $PdfList[$j] -replace("pdf", "pd_")
    Rename-Item $InputPath $RenamePath

    New-Item "$FileName.bdf" -type file
    
    $VendorNumber = $FileName.split("_")[0]
    $DocSecID = $FileName.split("_")[1]
    Add-Content -path "$FileName.bdf" -value "$InputPath|$VendorNumber|$DocSecID|" 
    
    
}