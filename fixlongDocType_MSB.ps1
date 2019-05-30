cls
function convert($inputDirectory){
    
    #Variable to hold current input directory 
    $InputPathFilter = $InputDirectory + '\APPRAISAL NOTIFICATION, APPRAISAL NOTICE AND ACKNOWLEDGEMENT, NOTICE OF RIGHT TO RECEIVE A COPY OF THE APPRAISAL.pdf'

    #Variable to hold the list of PDFs from the current input directory
    $PDFList = @(gci $InputPathFilter | foreach {write-output $_.name})
   

    #Loop through list of PDF files to convert to TIF image files.
    for ($j=0; $j -lt $PDFList.count; $j++) {   
        
        #Create a variable with only the file name
        $FileName = $PDFList[$j] -replace(".pdf",'')
        #Write-Host $FileName

        #Variable of the full path to the current PDF
	    $InputPath = $InputDirectory + '\' + $PDFList[$j]
		
	
        #Variable to hold the output path of each TIF file.  Filename format is used by MSB batcehs Page0001.tif, Page0002.tif....
	    $OutputFullDirectory = $inputDirectory + '\' + "Page" + '%04d.tif' 
	    #Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	    &'C:\Program Files\gs\gs9.16\bin\gswin64c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
        #Increment the counter for the loop
        $DocCounter = $j + 1
 
    }


 }
 $hostdirectory = "C:\Test\PAGE14"
 $folders = gci $hostdirectory
 foreach($folder in $folders){
 $fullNameFolder = $folder.FullName
    Write-Host "$fullNameFolder\APPRAISAL NOTIFICATION, APPRAISAL NOTICE AND ACKNOWLEDGEMENT, NOTICE OF RIGHT TO RECEIVE A COPY OF THE APPRAISAL.pdf"
     if(Test-Path -Path "$fullNameFolder\APPRAISAL NOTIFICATION, APPRAISAL NOTICE AND ACKNOWLEDGEMENT, NOTICE OF RIGHT TO RECEIVE A COPY OF THE APPRAISAL.pdf"){
        Write-Host "Found"
        convert -inputDirectory $fullNameFolder
     }else{
        #Write-Host "Not"
     }
        #convert -inputDirectory $folder.FullName
 }