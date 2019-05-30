cls
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=gemini-ps2;  Integrated Security=SSPI;  MultipleActiveResultSets=true;Connect Timeout=200")
## Open DB Connection
$conn.Open()

$sqlText = "SELECT *
            FROM AdventureWorks2014.HumanResources.Department"


 $cmd = New-Object System.Data.SqlClient.SqlCommand($sqlText, $conn)
    
    $Reader = $cmd.ExecuteReader()
    
  while ($Reader.Read()) {
        $DeptID = $Reader.GetValue(0)
        $name = $Reader.GetValue(1)
        Write-Host $DeptID $name
         
    }

    $conn.Close()