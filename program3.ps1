cls
$logFile = "C:\test\test12.txt"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

Function Get-FileName($initialDirectory)
{  
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName

$file = Get-FileName -initialDirectory "\\hyperion\cob" #"C:\test\test2\COB Birth records note with indexes.txt"

$pattern = "^(\d{1,5})`t(\d{4}-\d{2}-\d{2}) 00:00:00.000`t(\d{4})`t(BOSTON BIRTH)`t(.*)`t(\d{5})`t(.*)$"
$pattern2 = "^Boston-NT-NET\\\d{6}$"
$pattern3 = "^Author:(.*)$"
$pattern4 = (".*")
Get-Content $file|




ForEach-Object{
    #Write-Host $_
    if($_ -match $pattern){

        #Write-Host "I'm cool"
        $temp1 = $matches[1]
        $temp2 = $matches[2]
        $temp3 = $matches[3]
        $temp4 = $matches[4]
    }elseif($_ -match $pattern2){

        $temp5 = $matches[0]
        #Write-Host "$temp1|$temp2|$temp3|$temp4|$temp5"


    }elseif($_ -match $pattern3 -and $_ -ne $null){
        $temp5 = $matches[0]
        #Write-Host "$temp1|$temp2|$temp3|$temp4|$temp5"

    }elseif($_ -match $pattern4){
       
        [string]$temp6 = $matches[0]
        
        if($temp6 -ne ""){
            Write-Host $matches[0]
            Write-Host "$temp1|$temp2|$temp3|$temp4|$temp5|$temp6"
            LogWrite "$temp1|$temp2|$temp3|$temp4|$temp5|$temp6"
        }

    }



}