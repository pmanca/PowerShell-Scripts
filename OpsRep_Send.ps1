
#Connect to VPN
C: 
cd "C:\Program Files\Cisco Systems\VPN Client"
& ".\vpnclient.exe" connect WWVPN1 user sceris pwd sceris2water


#Map waterworks network path
net use W: \\wwfinance\TextBasedInvoices sceris2water /user:waterworks\sceris


#Push .gto and .tif files for text based invoices
C:
cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\TextBasedInvoices\Invoice"
copy-item *.GTO "W:\1_Invoices_Search_Replace"
cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\TextBasedInvoices\Invoice\Images"
copy-item *.tif "W:\1_Invoices_Search_Replace\Images"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\TextBasedInvoices\InvoiceStaples"
copy-item *.GTO "W:\1_StaplesInvoices_Search_Replace"
cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\TextBasedInvoices\InvoiceStaples\Images"
copy-item *.tif "W:\1_StaplesInvoices_Search_Replace\Images"


#Un-map drive
C:
net use W: /delete


#Map waterworks network path
net use W: \\wwfinance\GTOProcessing sceris2water /user:waterworks\sceris


#Push .gto and .tif files for Non-PO Non-PO Paid, PO, and Exceptions invoices
C:
cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\OriginalGTOs"
copy-item *.GTO "W:\1_lynx2GTOExport"
move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\OriginalGTOs\Old"

#cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\OriginalGTOs\No Vendor Exception"
#copy-item *.GTO "W:\1_lynx2GTOExport"
#move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\OriginalGTOs\Old"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\Images"
copy-item *.tif "W:\1_lynx2ImageExport"
move-item *.tif "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\Images\Old"


#Un-map drive
C:
net use W: /delete


#Disconnect from VPN
cd "C:\Program Files\Cisco Systems\VPN Client"
& ".\vpnclient.exe" disconnect
