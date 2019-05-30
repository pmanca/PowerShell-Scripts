cls
$LOGfile = "C:\test\DEA Images3.bdf"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $LOGfile -value $logstring
}
$pattern = "^(.*)_(\d{8}).tif$"
## Connect to the SQL server and the Database
$conn = New-Object System.Data.SqlClient.SqlConnection("Data Source=Gemini-ps1; Initial Catalog=COBDEA; Integrated Security=SSPI; MultipleActiveResultSets=true")
## Open DB Connection
$conn.Open()


$startingLocation = "X:\Dev_3 Tifs" 

$files = gci -path $startingLocation -recurse -Include "*.tif"

foreach($file in $files){
    
   # Write-Host $file.Name
    if($file.Name -match $pattern){
       # Write-Host $Matches[1]
        $temp = $Matches[1]
        $temp = $temp -replace "\'", "''"
        $sqlText = "SELECT EmpID, [First Name], [Middle N# or I#], [Last Name], [Document Type], [Transaction Type]
                    FROM [COBDEA].[dbo].[Sheet1$]
                    WHERE [Original File Name] LIKE '$temp%'"

        $cmd = new-object System.Data.SqlClient.SqlCommand($sqlText, $conn);
        $reader = $cmd.ExecuteReader()
        $results = @()
        $temp = ""
        while ($reader.Read())
        {
            $row = @{}
                for ($i = 0; $i -lt $reader.FieldCount; $i++)
                {
                    $row[$reader.GetName($i)] = $reader.GetValue($i)#used to generate a results file below that is commented out

                    $results += $reader.GetValue($i)
                    $temp += $reader.GetValue($i)
                    $temp += "|"
                }
                
                
              
        }
        write-host $results
        if($Matches[2] -eq '00010001'){
            $temp2 = "x:\"    
            $temp2 += $Matches[0]
            $temp2 += "|"
            $temp = $temp2 + $temp
             LogWrite -logstring $temp
             #Write-Host 'ea'
        }else{
            $temp = "x:\"
            $temp += $Matches[0]
            $temp += "|"
            LogWrite $temp
        }
        


     }
    
    
    
}

$conn.Close()