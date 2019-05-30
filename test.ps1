 function pdf2tif2([Object[]]$pdfs, $InputDirectory){

 for ($j=0; $j -lt $pdfs.count; $j++) {   
    #Each PDF will go into its own directory/batch 
    
    
    
    
    #Create a variable of the full path, with the timestamp
    $OutputFullDirectory = $InputDirectory + '\'+ 'Processed' 
    
    

    #Variable of the full path to the current PDF
	$InputPath = $InputDirectory + '\' + $pdfs[$j]
		
	
	#Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	$OutputFullDirectory = $OutputFullDirectory + '\'+ "{0:D4}" -f + ($j+1) + '%04d.tif' 
	 
	#Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	&'C:\Program Files\gs\gs9.16\bin\gswin64c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
    #Increment the counter for the loop
    $DocCounter = $j + 1

    #Rename the current pdf so that it isn't processed again.
	$RenamePath = $Pdfs[$j] -replace("pdf", "pd_")
    #Rename-Item $InputPath $RenamePath
    
    
    }
   
}

$InputDirectory = 'L:\Pioneer\ConcurTemp Files\'
$InputPathFilter = $InputDirectory + '\*.pdf'

$pdfs = @(gci $InputDirectory -Filter "*.pdf" | foreach {write-output $_.name})
Write-Host $pdfs.GetType()
    pdf2tif2 -pdList $pdfs -InputDirectory $InputDirectory


    
   