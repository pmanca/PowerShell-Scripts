#Connect to VPN
cls
C: 
cd "C:\Program Files (x86)\Cisco Systems\VPN Client"
& ".\vpnclient.exe" connect WWVPN1 user sceris pwd sceris2water
Write-Host "You Can use either or both the Vendor Number and Vendor Name. Invoice Number is a must"
$vendorNumber = Read-Host "Enter Vendor Number:"
$vendorName = Read-Host "Enter VendorName(Can be blank):"
$invoiceNumber = Read-Host "Enter Invoice Number:"

$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=wwfinance; Initial Catalog=ScerIS; Integrated Security=False; uid=PeterManca; pwd=Sc3r!s1; MultipleActiveResultSets=true")
## Open DB Connection
$conn.Open()

 $sqlText = "SELECT UdiValue1, UdiValue37, UdiValue38, UdiValue3
             FROM ScerIS.dbo.indexedRangesView_4
             WHERE (UdiValue37 like '%$vendorName%' OR UdiValue38 like '%$VendorNumber%') AND UdiValue3 = '$invoiceNumber' AND isDeleted = '0'"

    $cmd = New-Object System.Data.SqlClient.SqlCommand($sqlText, $conn)
    
    $Reader = $cmd.ExecuteReader()
    Write-Host "ARCHIVE DATE|VENDOR NAME|VENDOR NUMBER| INVOICE NUMBER"
  while ($Reader.Read()) {
     $ArchiveDate = $Reader.GetValue(0)
     $VendorName = $Reader.GetValue(1)
     $VendorNumber = $Reader.GetValue(2)
     $InvoiceNumber = $Reader.GetValue(3)
     Write-Host "$ArchiveDate|$VendorName|$VendorNumber|$invoiceNumber"
    }

    $conn.close()

    #Disconnect from VPN
cd "C:\Program Files (x86)\Cisco Systems\VPN Client"
& ".\vpnclient.exe" disconnect