$pdfCount = (Get-ChildItem "\\lynx2\Waterworks\Excel Based Invoices\PDFs" -filter "*.pdf").Count

Write-Host $pdfCount

if($pdfCount -eq 0){
    Exit
}


Write-Host "Exit did not work"