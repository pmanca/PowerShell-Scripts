# script to double check invoices being transfered properly
#Peter Manca 02/27/2015




cls
#Connect to VPN
C: 
cd "C:\Program Files (x86)\Cisco Systems\VPN Client"
& ".\vpnclient.exe" connect WWVPN1 user sceris pwd sceris2water




## Connect to the SQL server and the Database
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=Gemini1; Initial Catalog=SVCScerisProduction2; Integrated Security=SSPI")
## Open DB Connection
$conn.Open()

#grabs the current date
$date = [DateTime]::Today.AddDays(-1)
#query to see how many were archived today 
$sqlText = "Select Count(*)
From SVCScerISProduction2.dbo.IndexedRangesView_1
where UdiValue1 = '$date'"

#Below will create a sqlcommand object and then execute it using reader since we are only doing a query and not updating/inserting data.  

$cmd = new-object System.Data.SqlClient.SqlCommand($sqlText, $conn);
$reader = $cmd.ExecuteReader()

    while ($reader.Read())#to read the current data being stored in $reader after the $cmd is executed
    {
        $result = $reader.GetValue(0)#grabs the first and only value in the query result.  the count of the invoices
              
    }
write-host $result
$conn.Close()

#################################################################################################################################
##ww side
$user = "VPNScerISUser"
$pwd = "ww123"


## Connect to the SQL server and the Database
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=wwfinance; Initial Catalog=sceris; Integrated Security=False; uid=$user; pwd=$pwd")
## Open DB Connection
$conn.Open()

#grabs the current date should only need to grab it once
#$date = [DateTime]::Today.AddDays(-1)


#query to see how many were archived today 
$sqlText = "Select Count(*)
From sceris.dbo.IndexedRangesView_4
where UdiValue1 = '$date' and UdiValue46 IS NULL"

$cmd = new-object System.Data.SqlClient.SqlCommand($sqlText, $conn);
$reader = $cmd.ExecuteReader()

    while ($reader.Read())
    {
        $result2 = $reader.GetValue(0)
              
    }
write-host $result2
$conn.Close()

#Disconnect from VPN
cd "C:\Program Files (x86)\Cisco Systems\VPN Client"
& ".\vpnclient.exe" disconnect



#ForTesting# $result2 = 1

# if there is a difference in invoices archived then an email will be sent to sceris support
if($result -ne $result2){
    Write-Host "no match"
    $From = "scerissupport@sceris.com"
    $To = "scerissupport@sceris.com"
    #$Cc = ""
    #$Attachment = ""
    $Subject = "WaterWorks Error"
    $Body = "There is a mismatch in the number of invoices archived on Lynx2($result) and wwfinance($result2)"
    $SMTPServer = "dirsync.sceris.local"
    $SMTPPort = "25"

    Send-MailMessage -From $From -to $To -Subject $Subject `
    -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
    #-Credential (Get-Credential) picked up automatically by svcscerisservice which is the account running the script.  if this changes then the new account will need permisssion to the support account to send email  
}