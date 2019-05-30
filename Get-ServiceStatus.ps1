function Get-ServiceStatus ([string[]]$server)
{
 foreach ($s in $server)
 {
   if(Test-Connection $s -Count 2 -Quiet)
   {
    Get-WmiObject win32_Service -Computer $s |
     where {$_.DisplayName -match "SQL Server"} | 
     select SystemName, DisplayName, Name, State, Status, StartMode, StartName
   }
 }
}

Get-ServiceStatus -server "ursa2"