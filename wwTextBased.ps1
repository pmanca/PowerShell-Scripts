cls

$pdfCount = Get-ChildItem "\\lynx2\Waterworks\Excel Based Invoices\PDFs" -filter "*.pdf"
Write-Host $pdfCount

if(!$pdfCount){
    Exit
}else{


    #Variable to hold current input directory 
    $InputDirectory = '\\lynx2\Waterworks\Excel Based Invoices\PDFs'
    $InputPathFilter = $InputDirectory + '\*.pdf'

    #Variable to hold current output directory
    $OutputDirectory = '\\lynx2\Waterworks\Excel Based Invoices\PDFs\TIFs'

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

    
        #Create a variable of the full path, with the timestamp
        $OutputFullDirectory = $OutputDirectory # + $FileName
    
        #Create the subdirectory for the current PDF
        if ((Test-Path $OutputFullDirectory) -ne $TRUE) {
	        New-Item $OutputFullDirectory -type directory
        }

        #Variable of the full path to the current PDF
	    $InputPath = $InputDirectory + '\' + $PDFList[$j]
		
	
	    #Variable to hold output path of each TIF file.  Filename format is that used by batches in ScerIS (i.e. 00010001.tif, 00010002.tif, etc...)
	    $OutputFullDirectory = $OutputFullDirectory + '\' + $FileName + "_" + "{0:D4}" -f + '1' + '%04d.tif' 
	 
	    #Calls Ghostscript command line executable to process each PDF file into a group of single page TIF image files
	    &'C:\Program Files (x86)\gs\gs9.14\bin\gswin32c.exe' -sDEVICE=tiffg4 -dBATCH -dNOPAUSE -q -r600 "-sOutputFile=$OutputFullDirectory" "$InputPath"
	
        #Increment the counter for the loop
        $DocCounter = $j + 1

        #Rename the current pdf so that it isn't processed again.
	    $RenamePath = $PdfList[$j] -replace("pdf", "pd_")
       # if(!(Test-Path $RenamePath)){
           # $randomNumber = Get-Random -Minimum 1 -Maximum 999
           # Rename-Item $InputPath "$randomNumber.pd_"
        #}else{
           Rename-Item $InputPath $RenamePath -Force
        #}
    
    
    }

    #Project         : 2(Subledger)
    #BU              : 2(Business Unit)
    #NREDesc         : 2(GL Remarks)
    #VendorNumber    : 1
    #FreightPONumber : 2(PO Number)
    #Subsidiary      : 2
    #VendorName      : 1                
    #TY              : 2(Subledger Type)
    #OBJ             : 2(GL Account)
    #InvoiceNumber   : 1
    #ExtAmt          : 2(Extended Price)
    #Tax             : 2
    #Currency        : 1
    #InvoiceDate     : 1
    #ApproverName    : 1
    #PaymentTerms    : 1



    $date = Get-Date -Format g
    $date = $date -replace "/", "."
    $date = $date -replace ":"," "
    $BDFFileLocation = "\\lynx2\Waterworks\Excel Based Invoices\PDFs\BDFs"
    $BDFFile = "$BDFFileLocation\$date.bdf" #name of BDF file
    $count = 0 # coutns for output file for results
    Function BDFWrite #Function to write BDF file
    {
       Param ([string]$logstring)

       Add-content $BDFfile -value $logstring
    }



    #Variable to hold the location of the tifs that have been converted from pdf
    $files = gci $OutputDirectory -filter "*.tif"


    foreach($file in $files){

        if($file.BaseName -match ".*00010001.*"){#will process for only the first page in each batch
       
   
           $count++
           $Level2Count = 0 #counts the number of occurences so level 1 won't write itself out more than once
           $invoiceNumber = $file.BaseName.Split("_")[0]#takes the invoice number from the file name
           $vendorNumber  = $file.BaseName.Split("_")[1] #takes the vendor number from the file name
           Write-Host $invoiceNumber " - " $vendorNumber
   
            #creates a sql connection
            $cn2 = new-object system.data.SqlClient.SQLConnection("Data Source=gemini1;Integrated Security=SSPI;Initial Catalog=SVCWaterWorksProduction");
            #The sql command that will be executed
            $cmd = new-object system.data.sqlclient.sqlcommand("SELECT CONVERT(varchar(10),i.InvoiceDate,101) AS InvoiceDate, v.AddressNumber, v.PaymentTerms, i.Currency, i.InvoiceNumber, i.VendorNumber, RTRIM(v.VendorName), i.BU,  i.ExtAmt,  i.NREDesc, i.OBJ, i.Project, i.Subsidiary, i.TY,  i.Tax, i.FreightPONumber
        FROM TextInvoices i INNER JOIN VendorMaster v ON i.VendorNumber = v.VendorNumber
        WHERE InvoiceNumber = '$invoiceNumber' AND v.VendorNumber = $vendorNumber AND (ISNULL(i.Processed, '') = '')
        ", $cn2);
            $cn2.Open();#opens the sql connection
  
            $reader = $cmd.ExecuteReader()#executes the sql command
            $name = $file.FullName#name of the tif file
            $temp = "$name|L|9|~"#starts the line of the bdf with the tif name
            $results = @()
            while ($reader.Read())#reads the output of the sql command in process so to write to bdf file
            {
        
                $row = @{}
                for ($i = 0; $i -lt $reader.FieldCount; $i++)
                {
                    $row[$reader.GetName($i)] = $reader.GetValue($i)#used to generate a results file below that is commented out
            
                    if($Level2Count -eq 0){#distinguishes between level 1 and level 2 data
                        $temp += $reader.GetValue($i)
               
                        if($i -eq 6){
                            $temp += "~|"
                            $Level2Count++
                        }else{
                            $temp +="|"
                        }
                    }elseif($Level2Count -gt 0 -and $i -gt 6){
                        $temp += $reader.GetValue($i)
                        $temp +="|"
                    }
                }
                #$results += new-object psobject -property $row      #Won't work with RTRIM in the select statement 
         
                 
            }
           # if($reader -ne $null){
                 BDFWrite $temp #writes out to the bdf file
           # }
        
            $cn2.Close();#closes the sql connection
            #$results|Out-File "C:\test\test$count.txt"


            $date = Get-Date -Format d #get current date
            #sql command to be executed
            $cmd = new-object system.data.sqlclient.sqlcommand("Update SVCWaterWorksProduction.dbo.TextInvoices
            set Processed = 'Y', ProcessedDate = '$date'
            Where InvoiceNumber = '$invoiceNumber' and VendorNumber = '$vendorNumber' and (Processed = '' or Processed is NUll);", $cn2);
            $cn2.Open();  #opens up the connection  
            $reader = $cmd.ExecuteReader()#executes the commnad
            while ($reader.Read())
            {
        
                $row = @{}
                for ($i = 0; $i -lt $reader.FieldCount; $i++)
                {
                    $row[$reader.GetName($i)] = $reader.GetValue($i)#for the results commented out belwo in case of putput file needed
            
                
                }
                 #$results += new-object psobject -property $row|Out-File "c:\test\huess.txt"  
            }  
           
        }
        else{
          #  if($reader -ne $null){
                $temp = $file.FullName
                $temp += "|"
                BDFWrite $temp #writes out the remaining tif names to the bdf file.  
           # }
        }
    }


     $cn2.Close();#closes the sql connection


}#end of pdfCount else

#below purges teh old pdfs and tifs that are over 2 weeks old.  


$fileNames=@()
$fileNames = Get-ChildItem "\\lynx2\Waterworks\Excel Based Invoices\PDFs" -Filter "*.pd_"| Where{$_.LastWriteTime -lt (Get-Date).AddDays(-14)}


 Write-Host $fileNames

 foreach($file in $fileNames)
{
    Remove-Item -path $file.FullName
}


$fileNamestifs=@()
$fileNamestifs = Get-ChildItem "\\lynx2\Waterworks\Excel Based Invoices\PDFs\TIFs\Sent" -Filter "*.tif"| Where{$_.LastWriteTime -lt (Get-Date).AddDays(-14)}


 Write-Host $fileNamestifs

 foreach($file in $fileNamestifs)
{
    Remove-Item -path $file.FullName
}