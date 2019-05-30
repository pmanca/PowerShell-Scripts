cls

$name = (Get-Date -Format yyyyMMddHHmmss)

$bdf = "\\hubble\nell\Groups\IT\Gemini1 DB size history\$name.csv"

$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=gemini1;  Integrated Security=SSPI;  MultipleActiveResultSets=true")
## Open DB Connection
$conn.Open()

 $sqlText = "SELECT d.name, ROUND(SUM(mf.size) * 8 / 1024, 0) Size_MBs
FROM sys.master_files mf
INNER JOIN sys.databases d ON d.database_id = mf.database_id
WHERE d.database_id > 4 -- Skip system databases
GROUP BY d.name
ORDER BY d.name"

    $cmd = New-Object System.Data.SqlClient.SqlCommand($sqlText, $conn)
    
    $Reader = $cmd.ExecuteReader()
    
  while ($Reader.Read()) {
     $DBName = $Reader.GetValue(0)
     $DBSize = $Reader.GetValue(1)
     
     $temp = "$DBName,$DBSize"
     Add-Content -Path $bdf -Value $temp
         
    }
    
    $conn.close()