cls
#Peter Manca
#Scritpt to process the Pioneer Concur files

#NOTE!  You must have a mapped drive set up to BrickFTP  That is what the F is in the 
#files variable



#Global Variables
$files = gci "F:\ScerIS Customers\Pioneer\Files from Pioneer\*.zip"
$pioneerDest = "\\lynx2\Customers\Pioneer\ConcurTemp Files"
$OutputDirectory = "\\lynx2\Customers\Pioneer\ConcurTemp Files\Processed"
$logFile = "$pioneerDest\Logs\ConcurLog.txt"

##############################################################################
#Functions

function Expand-ZIPFile($file, $destination)
{
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items())
    {
        $shell.Namespace($destination).copyhere($item)
    }
}

function BDF-Write($inputString, $fileName)
{
    #Write-Host "Log file " $fileName
    Add-Content -Path $fileName -Value $inputString
}

function Log-Write($inputString){
    Add-Content $logFile -Value $inputString
}

function Send-Mail($From, $To, $Subject, $Body, $SMTPServer, $SMTPPort){
    #ScerIS Mail Server: dirsync.sceris.local
    #ScerIS Mail Server Port: 25
    #IT will need to add the Ip address to dirsync for the machine that will be using this. 
    #This function is added in just in case someone or yours truly wants to implement it in the future.
    Send-MailMessage -From $From -to $To -Subject $Subject `
    -Body $Body -SmtpServer $SMTPServer -port $SMTPPort
    
    
}

function pdf2tif($input2, $InputDirectory)
{
        
        #Create a variable with only the file name
        $FileName = $input2 -replace(".pdf",'')
        

        #Variable of the full path to the current PDF
	    $InputPath = $InputDirectory + '\' + $input2
		
	
	    #Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	    $OutputFullDirectory = $InputDirectory + '\'+ 'Processed\' + $FileName + '.tif'
	    
	    #Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	    &'C:\Program Files\gs\gs9.16\bin\gswin64c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
        #Rename the current pdf so that it isn't processed again.
	    $RenamePath = $input2 -replace("pdf", "pd_")
        Rename-Item $InputPath $RenamePath

}






######################################################################################
#Script

if(!(Test-Path -Path "F:\ScerIS Customers\Pioneer\Files from Pioneer\*.zip")){
    Write-host "Connect to Brick"
    EXIT
}

#Making sure folders are there
if(!(Test-Path -Path "$pioneerDest\Processed")){
    New-Item -Path "$pioneerDest\Processed" -Type directory
}
if(!(Test-Path -Path "$pioneerDest\Processed\Completed")){
    New-Item -Path "$pioneerDest\Processed\Completed" -Type directory
}
if(!(Test-Path -Path "$pioneerDest\Error")){
    New-Item -Path "$pioneerDest\Error" -Type directory
}
if(!(Test-Path -Path "$pioneerDest\Logs")){
    New-Item -Path "$pioneerDest\Logs" -Type directory
}
if(!(Test-Path -Path "$pioneerDest\Processed\OldCSV")){
    New-Item -Path "$pioneerDest\Processed\OldCSV" -Type directory
}


$oldPdf = gci $pioneerDest -Filter "*.pd_"
foreach($file0 in $oldPdf){
    $oldPdfName = $file0.FullName
    Remove-Item -Path $oldPdfName
}
$oldCSV = gci "$pioneerDest\Processed" -Filter "*.csv"
foreach($file0 in $oldCSV){
    $oldCsvName = $file0.FullName
    Move-Item -Path $oldCsvName -Destination "$pioneerDest\Processed\OldCSV"
}



#copies files from brick
foreach($file in $files){
    Write-Host $file.FullName
    Copy-Item -Path $file.FullName -Destination $pioneerDest
    $zipName = $file.Name
    #Write-Host "$pioneerDest\$zipName"
    Expand-ZIPFile -file "$pioneerDest\$zipName" -destination $pioneerDest
    Remove-Item -Path "$pioneerDest\$zipName"
    
}
#Grabs all csv
$filesCSV = gci $pioneerDest -Filter "*.csv"
$arrPDFName = New-Object System.Collections.ArrayList
#Loops through each csv file
foreach($file2 in $filesCSV){
    $pdfs = gci $pioneerDest -Filter "*.pdf"
    $Global:arr = Import-Csv -Path $file2.FullName -Header "ReportID","RecordID","EmployeeID"
    $arrPDFName.Clear()
    #fill in arrPDFName which holds the pdf names from the csv file
    for($i = 0; $i -lt $arr.Length; $i++){
        $name = $arr[$i].ReportID.ToString() + ".pdf"
        if(Test-Path -Path "$pioneerDest\$name"){
            $arrPDFName.Add($arr[$i].ReportID.ToString() + ".pdf")
        }else{
            Write-Host "No Match " $name
        }
    }
    
    #if the number of pdfs don't match the number of pdfs in csv file
    if($arr.Length -ne $arrPDFName.Count){
        Write-Host "arr " $arr.Length  " count " $arrPDFName.Count
        for($i = 0; $i -lt $arrPDFName.Count;$i++){
           $pdfName = $arrPDFName[$i]
           $fName = $file2.Name
           Move-Item -Path "$pioneerDest\$pdfName" -Destination "$pioneerDest\Error"
           if(Test-Path -Path $file2.FullName){
                Move-Item -Path "$pioneerDest\$fName" -Destination "$pioneerDest\Error"
           }
        }
        #Can you mail function here
        $CSV = $file2.Name
        $temp = "Error on file: " +  $CSV +  " Missing image: " + $name 
        log-Write -inputString $temp 
        continue
    }#end of error if check

    #convert pdf to tif image
    foreach($pname in $arrPDFName){
        pdf2tif -input2 $pname -InputDirectory $pioneerDest
    }

    #Write out to BDF
    for($i = 0;$i -lt $arr.Length; $i++){
        $nameTemp = $arr[$i].ReportID.toString()
        $recordIDTemp = $arr[$i].RecordID.toString()
        $EmpTemp = $arr[$i].EmployeeID.toString()
        $fileNameTemp = "$pioneerDest\Processed\$nameTemp.tif"
        $temp = "$fileNameTemp|$nameTemp|$recordIDTemp|$EmpTemp"
        #$BDFFile = [io.path]::ChangeExtension($file2.FullName, 'bdf')
        $fBase = $file2.BaseName
        $BDFFile = "$pioneerDest\Processed\$fBase.bdf"
        BDF-Write -inputString $temp -fileName $BDFFile   
    }

    $temp = "Processed: " + $file2.Name
    Log-Write -inputString $temp
    Move-Item -Path $file2.FullName -Destination "$pioneerDest\Processed"
}

























