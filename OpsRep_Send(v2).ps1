## Connect to the SQL server and the Database
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=Gemini1; Initial Catalog=SVCWaterworksProduction; Integrated Security=SSPI")
## Open DB Connection
$conn.Open()

#Connect to VPN
C: 
cd "C:\Program Files\Cisco Systems\VPN Client"
& ".\vpnclient.exe" connect WWVPN1 user sceris pwd sceris2water

#Map waterworks network path
net use W: \\wwfinance\TextBasedInvoices sceris2water /user:waterworks\sceris

#sql insert text based bdf
$SrcDir = "\\lynx2\Waterworks\Excel Based Invoices\PDFs\BDFs"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.BDF -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert text based tif
$SrcDir = "\\lynx2\Waterworks\Excel Based Invoices\PDFs\TIFs"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.tif -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#Push .bdf and .tif files for text based invoices
C:
cd "\\lynx2\Waterworks\Excel Based Invoices\PDFs\TIFs"
copy-item *.tif "W:\1_Invoices_Search_Replace\Images"
move-item *.tif "\\lynx2\Waterworks\Excel Based Invoices\PDFs\TIFs\Sent"

cd "\\lynx2\Waterworks\Excel Based Invoices\PDFs\BDFs"
copy-item *.BDF "W:\1_Invoices_Search_Replace"
move-item *.BDF "\\lynx2\Waterworks\Excel Based Invoices\PDFs\BDFs\Sent"

#sql insert text based gto
$SrcDir = "W:\1_Invoices_Search_Replace"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert text based tif
$SrcDir = "W:\1_Invoices_Search_Replace\Images"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.tif -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#Un-map drive
C:
net use W: /delete

#Map waterworks network path
net use W: \\wwfinance\GTOProcessing sceris2water /user:waterworks\sceris

#sql insert exceptions no vendor gto
$SrcDir = "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exception-NoVendor\Archived"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert exceptions gto
$SrcDir = "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exceptions\Archived"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert nonpo gto
$SrcDir = "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\NONPO\Archived"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert po gto
$SrcDir = "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\PO\Archived"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert tif
$SrcDir = "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\Images\Archived"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.tif -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesBeforeTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#Push .gto and .tif files for Non-PO, Exceptions-NoVendor, Exceptions, and PO invoices
C:
cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\Images\Archived"
copy-item *.tif "W:\1_lynx2ImageExport"
move-item *.tif "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\Images\Archived\Sent"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exception-NoVendor\Archived"
copy-item *.GTO "W:\1_lynx2GTOExport\2_Exceptions_NoVendor_Search_Replace"
move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exception-NoVendor\Archived\Sent"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exceptions\Archived"
copy-item *.GTO "W:\1_lynx2GTOExport\2_Exceptions_Search_Replace"
move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\Exceptions\Archived\Sent"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\NONPO\Archived"
copy-item *.GTO "W:\1_lynx2GTOExport\2_NonPO_Search_Replace"
move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\NONPO\Archived\Sent"

cd "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\PO\Archived"
copy-item *.GTO "W:\1_lynx2GTOExport\2_PO_Search_Replace"
move-item *.GTO "\\lynx2\Waterworks\AnyDoc\AnyDocOutput\GTOs\PO\Archived\Sent"

#sql insert exceptions no vendor gto
$SrcDir = "W:\1_lynx2GTOExport\2_Exceptions_NoVendor_Search_Replace"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert exceptions gto
$SrcDir = "W:\1_lynx2GTOExport\2_Exceptions_Search_Replace"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert nonpo gto
$SrcDir = "W:\1_lynx2GTOExport\2_NonPO_Search_Replace"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert po gto
$SrcDir = "W:\1_lynx2GTOExport\2_PO_Search_Replace"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.GTO -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#sql insert tif
$SrcDir = "W:\1_lynx2ImageExport"
$fileEntries = Get-ChildItem -Path $SrcDir -Filter *.tif -Force;
foreach($file in $fileEntries) 
{
#Create SQL Insert Statement with your values
$fileName = $file.ToString()
$filePath = $file.FullName.ToString()
$time = $file.CreationTime.ToString()
$insTime = Get-Date
$insert_stmt = "INSERT INTO FilesAfterTransfer(filePath, FileName,CreationTime,InsertTime) VALUES('$filePath','$fileName','$time','$insTime')"
## Create your command
$cmd = $conn.CreateCommand()
$cmd.CommandText = $insert_stmt
## Invoke the Insert statement
$cmd.ExecuteNonQuery()
}

#Un-map drive
C:
net use W: /delete

#Disconnect from VPN
cd "C:\Program Files\Cisco Systems\VPN Client"
& ".\vpnclient.exe" disconnect

## Close DB Connection
$conn.Close()



