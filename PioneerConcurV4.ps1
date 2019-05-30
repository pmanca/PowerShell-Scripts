cls
#Peter Manca
#Scritpt to process the Pioneer Concur files

#NOTE!  You must have a mapped drive set up to BrickFTP  That is what the F is in the 
#files variable

#V4 UPDATE
#V4 flipped the RecordID and EmployeeID per Lisa's request.



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

function BCH-Write($inputString, $fileName)
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






######################################################################################
#Script
#Making sure the connection to the brickftp is there
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

#Clean up from the last time
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
    #V4 flipped the RecordID and EmployeeID per Lisa's request.
    $Global:arr = Import-Csv -Path $file2.FullName -Header "ReportID","EmployeeID","RecordID"
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
        #the continue statement will automatically go to the next interation of the loop
        continue
    }#end of error if check

    
    
    $pdfs = @(gci -Path $pioneerDest -Include $arrPDFName -Recurse | Select-Object -Expand Name)
    Write-Host $pdfs
    
    for ($j=0; $j -lt $pdfs.count; $j++) {   
    
    $InputDirectory = $pioneerDest
    
    
    
    #Create a variable of the full path, with the timestamp
    $OutputFullDirectory = $InputDirectory + '\'+ 'Processed' 
    
    if($pdfs.Contains($arr[$j].ReportID.toString() + ".pdf")){
        write-host "true"
    }
    

    #Variable of the full path to the current PDF
	$InputPath = $InputDirectory + '\' + $arr[$j].ReportID.toString() + ".pdf"
	#$InputPath = $pdfs[$j]	
	
	#Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	$OutputFullDirectory = $OutputFullDirectory + '\'+ "{0:D4}" -f + ($j+1) + '%04d.tif' 
	 
	#Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	#Peter's Machine
    #&'C:\Program Files\gs\gs9.16\bin\gswin64c.exe' -sDEVICE=tiffgray -dBATCH -dNOPAUSE -q -r300 "-sOutputFile=$OutputFullDirectory" "$InputPath"
    #For Lisa's machine
    &'C:\Program Files\gs\gs9.19\bin\gswin64c.exe' -sDEVICE=tiffgray -dBATCH -dNOPAUSE -q -r300 "-sOutputFile=$OutputFullDirectory" "$InputPath"

    #Increment the counter for the loop
    $DocCounter = $j + 1

    #Rename the current pdf so that it isn't processed again.
	$RenamePath = $Pdfs[$j] -replace("pdf", "pd_")
    Rename-Item $InputPath $RenamePath
    
    
    }
    #Write out to BDF
    
    $fBase = $file2.BaseName

    $BDFFile = "$pioneerDest\Processed\$fBase.BCH"
    #Static text for the top of the BCH file
    [string]$temp = "5
3
Report ID
1 0 0 0 0 100 0 0 0 0 0 0


0 0 0 1
Record Key
0 0 0 0 0 100 0 0 0 0 0 0


0 0 0 0
Employee ID
0 0 0 0 0 100 0 0 0 0 0 0


0 0 0 0"
    BCH-Write -inputString $temp -fileName $BDFFile
    #Writes out the number of different image sets so the first 4 numbers
    #in the sceris batch notation
    BCH-Write -inputString $arr.Length -fileName $BDFFile
    for($i = 0; $i -lt $arr.length; $i++){
            $nameTemp = $arr[$i].ReportID.toString()
            $recordIDTemp = $arr[$i].RecordID.toString()
            $EmpTemp = $arr[$i].EmployeeID.toString()
            $x = $i + 1
           
            #Gets the count of images within each image set     
            if($x -lt 10){
                $count = 0
                $pattern = ".*000$x\d{4}.tif"
                $tifs = gci "$pioneerDest\Processed" -Filter "*.tif"
                foreach($tif in $tifs){
                    $name = $tif.name
                    if($name -match $pattern){
                        $count++          
                    }
                }
            }elseif($x -gt 9){
                $count = 0
                $pattern = ".*00$x\d{4}.tif"
                $tifs = gci "$pioneerDest\Processed" -Filter "*.tif"
                foreach($tif in $tifs){
                    $name = $tif.name
                    if($name -match $pattern){
                       $count++          
                    }
               }
            }
            BCH-Write -inputString $count -fileName $BDFFile

            #Writes out the appropriate  images in order
            if($x -lt 10){
                $pattern = ".*000$x\d{4}.tif"
                $tifs = gci "$pioneerDest\Processed" -Filter "*.tif"
                foreach($tif in $tifs){
                    $name = $tif.name
                    if($name -match $pattern){
                        BCH-Write -inputString $name -fileName $BDFFile          
                    }
                }
            }elseif($x -gt 9){
                $pattern = ".*00$x\d{4}.tif"
                $tifs = gci "$pioneerDest\Processed" -Filter "*.tif"
                foreach($tif in $tifs){
                    $name = $tif.name
                    if($name -match $pattern){
                        BCH-Write -inputString $name -fileName $BDFFile          
                    }
               }
            }
            
            #static print out inbetween images and indexes
            $temp = "1
1
0
F NONE NONE F T
3"
            BCH-Write -inputString $temp -fileName $BDFFile
            #Prints out the indexes seperated by a \n0
            BCH-Write -inputString $nameTemp -fileName $BDFFile  
            BCH-Write -inputString "0" -fileName $BDFFile  
            BCH-Write -inputString $RecordIDTemp -fileName $BDFFile
            BCH-Write -inputString "0" -fileName $BDFFile    
            BCH-Write -inputString $EmpTemp -fileName $BDFFile  
            BCH-Write -inputString "0" -fileName $BDFFile    



            #Tests for the paths in the batches folder.  Pioneer Concur Images folder is Z74
            if(!(Test-Path -Path "\\lynx2\ScerISData\AuxFiles\Batches\z75\$fBase")){
                New-Item -Path "\\lynx2\ScerISData\AuxFiles\Batches\z75\$fBase" -Type directory
            }
           #Copies each tif over to the batches folder
           foreach($tif in $tifs){
            #Copy-Item -Path $tif.FullName -Destination  "\\lynx2\ScerISData\AuxFiles\Batches\z74\$fBase\"
            Move-Item -Path $tif.FullName -Destination  "\\lynx2\ScerISData\AuxFiles\Batches\z75\$fBase\"
           }


    }
    #Static block for Current Doc, Current Page, Current Index Set
    BCH-Write -inputString "0 0 0" -fileName $BDFFile
    #Copies BCH file to the batches folder
    Copy-Item -Path $BDFFile -Destination "\\lynx2\ScerISData\AuxFiles\Batches\z75\$fBase"
    
    #writes out to the logs if a sucess and moves the csv file to the processed folder
    $temp = "Processed: " + $file2.Name
    Log-Write -inputString $temp
    Move-Item -Path $file2.FullName -Destination "$pioneerDest\Processed"
}

























