#&'C:\Program Files\gs\gs9.14\bin\gswin64c.exe' -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=finished.pdf file*pdf



$tool = 'C:\Program Files\gs\gs9.14\bin\gswin64c.exe'
$pdfs = get-childitem "M:\Personal\Lease2"  
$batch = "-dBATCH"
foreach($pdf in $pdfs)
{

        'Processing ' + $pdf.Name    
            
        $batch += " $pdf"
        Write-Host $batch

     
}
$output = "-sOutputFile=M:\Personal\Lease2\finished3.pdf"
& $tool  -dNOPAUSE -sDEVICE=pdfwrite $output $batch  -c quit