cls
#This script is made to convert vendors from PO to NON PO so the service center can process WaterWorks invoices
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=Gemini1; Initial Catalog=SVCWaterworksProduction; Integrated Security=SSPI; MultipleActiveResultSets=true")
## Open DB Connection
$conn.Open()
$loopTest = $TRUE
while($loopTest){
    $vendorName = Read-Host "Enter Vendor Name: "

    #Query to make sure only one vendor is selected
    $sqlText = "SELECT Count(*)
                FROM SVCWaterworksProduction.dbo.VendorMaster
                WHERE VendorName like '%$vendorName%'"

    $cmd = New-Object System.Data.SqlClient.SqlCommand($sqlText, $conn)
    
    $reader = $cmd.ExecuteReader()
    while($reader.Read()){
        $result = $reader.GetValue($1)
    }
    #Write-Host $result
    if($result -eq 1){#if only one is selected then...
        #Query to update vendor master table on Gemini1
        $sqlText2 = "UPDATE SVCWaterworksProduction.dbo.VendorMaster
                    SET VendorClass = 'SVC'
                    WHERE VendorName like '%$vendorName%'"
        $cmd2 = new-object System.Data.SqlClient.SqlCommand($sqlText2, $conn)

    $cmd2.ExecuteNonQuery()
    $loopTest = $FALSE
    }else{
        Write-Host "Please be more specific"#reacehd if more than one company is selected
    }
}
$conn.close()