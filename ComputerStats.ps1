cls
$logFile = "C:\test\computerInfo.txt"
function Get-ComputerStats {
  param(
    [Parameter(Mandatory=$true, Position=0, 
               ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [string]$C#omputerName
  )

  process {
        $date = Get-Date -Format g
    #foreach ($c in $ComputerName) {
        $avg = Get-WmiObject win32_processor -computername $c | 
                   Measure-Object -property LoadPercentage -Average | 
                   Foreach {$_.Average}
        $mem = Get-WmiObject win32_operatingsystem -ComputerName $c |
                   Foreach {"{0:N2}" -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize)}
        $free = Get-WmiObject Win32_Volume -ComputerName $c -Filter "DriveLetter = 'C:'" |
                    Foreach {"{0:N2}" -f (($_.FreeSpace / $_.Capacity)*100)}
        
    return "$date|$c|$avg|$mem|$free|"
    #}
  }

  }
  if(!(Test-Path $logFile)){
    New-Item -Path $logFile -ItemType file
  }
  if((Get-Content $logFile) -eq $Null){
    Add-Content -Path $logFile -value "Date|ComputerName|CPUAverage|MemoryUsage|FreeDiskSpace"
  }
  Get-ComputerStats('localhost')|Add-Content $logFile
