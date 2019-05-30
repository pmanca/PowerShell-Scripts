cls
#
#
Function BDFWrite([string]$logstring)
{
   Add-content $LOGFile -value $logstring
}
function convert($inputDirectory){
    
    #Variable to hold current input directory 
    $InputPathFilter = $InputDirectory + '\*.pdf'

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




$folders = gci -Path "C:\Test\"


foreach($folder in $folders){
    Write-Host $folder
    $hostdirectory = $folder.FullName
    $hostPlusCredit = "$hostdirectory\CREDIT FOLDER"
    $LOGFile = "$hostdirectory\MSBLog.bdf"
    #count 1 = Loan Number
    #count 4 = Cust Num
    #count 5 = Document Type
    $loanNumber
    $CustNumber
    $DocType
    $CreditPattern = "\(R\).*"
    #BDFwrite -logstring "LoanNum|CustNum|DocType"
    $count = 0
    $file = (Select-xml -Path "$hostdirectory\index.xml" -XPath / ).Node


    $test = $file.ExportedResult.Docs.ExportedDoc.Doc.UdiValues.UdiValue.Value


     $test | ForEach-Object{
        $count++

        if($count -eq 1){
            [string]$xmlHold = $_.InnerXML
            $loanNumber = $xmlHold
            $hostdirectoryPlusLoan =  "$hostdirectory\$xmlHold"
            if(!(test-path $hostdirectoryPlusLoan)){
                New-Item $hostdirectoryPlusLoan -ItemType directory 
            }
        }
        if($count -eq 4){
            [string]$xmlHold = $_.innerXML
            $CustNumber = $xmlHold
        }
        if($count -eq 5){
            [string]$xmlHold = $_.InnerXML
            $DocType = $xmlHold
            $xmlHoldNoSpace = $xmlHold -replace '\s', ''
            $DocType = $DocType -replace '\&amp;', '&'
            $xmlHoldNoSpace = $xmlHoldNoSpace -replace '\&amp;', '&'
            if($DocType -match $CreditPattern){
                if(!(test-path $hostPlusCredit)){
                    New-Item $hostplusCredit -ItemType directory
                }
                $hostPlusCreditPlusCustNumber = "$hostPlusCredit\$CustNumber"
                if(!(Test-Path $hostPlusCreditPlusCustNumber)){
                    New-Item $hostPlusCreditPlusCustNumber -ItemType directory
                }
                $hostPlusCreditPlusCustNumberPlusDocType = "$hostPlusCreditPlusCustNumber\$DocType"
                if(!(Test-Path $hostPlusCreditPlusCustNumberPlusDocType)){
                    New-Item $hostPlusCreditPlusCustNumberPlusDocType -ItemType directory
                }
                if(Test-Path "$hostdirectory\$DocType.pdf"){
                    $check = Copy-Item  "$hostdirectory\$DocType.pdf" -Destination $hostPlusCreditPlusCustNumberPlusDocType -ErrorAction SilentlyContinue
                    #if(-not $?) {write-warning "Copy Failed"; Write-Host $Error[0].exception.message}
                    #else {write-host "Succes"} 
                    convert -inputDirectory $hostPlusCreditPlusCustNumberPlusDocType
                }
            }else{
                $hostdirectoryPlusLoanPlusDocType =  "$hostdirectoryPlusLoan\$DocType"#$xmlHoldNoSpace"
                if(!(test-path $hostdirectoryPlusLoanPlusDocType)){
                    New-Item $hostdirectoryPlusLoanPlusDocType -ItemType directory
                }
                if(Test-Path "$hostdirectory\$DocType.pdf"){
                    $check = Copy-Item  "$hostdirectory\$DocType.pdf" -Destination $hostdirectoryPlusLoanPlusDocType -ErrorAction SilentlyContinue
                    #if(-not $?) {write-warning "Copy Failed"; Write-Host $Error[0].exception.message}
                    #else {write-host "Succes"} 
                    convert -inputDirectory $hostdirectoryPlusLoanPlusDocType
                }
            } 
        }
        if($count -ge 8){
            $count = 0
            if($DocType -match $CreditPattern){
                $temp = "CREDIT FOLDER|$CustNumber|$DocType"
                if(!($temp -eq $tempOldHold)){
                    $tempOldHold = $temp
                    BDFWrite -logstring $temp
                }
                $tempOldHold = $temp
            }else{
                $temp = "$LoanNumber|$CustNumber|$DocType"
                if(!($temp -eq $tempOldHold)){
                    $tempOldHold = $temp
                    BDFWrite -logstring $temp
                }
                $tempOldHold = $temp
            }
        }

     }
     #clean up
     gci $hostdirectory -Include *.pdf , *.xml , *.xsl  -Recurse | foreach($_){Remove-Item $_.FullName}
 }