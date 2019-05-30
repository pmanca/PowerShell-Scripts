cls

function Convert-FromRtf ($Path)
{
    $Rtb = New-Object -TypeName System.Windows.Forms.RichTextBox
    $Rtb.Rtf = [System.IO.File]::ReadAllText($Path)
    Set-Content -Path "C:\Temp\Powershell\SNCH-APDISTRIBUTION-(Page Break)_1.rpt.txt" $Rtb.Text
    Remove-Variable Rtb -ErrorAction SilentlyContinue
} 


Convert-FromRtf "C:\Temp\Powershell\SNCH-APDISTRIBUTION-(Page Break)_1.rpt.rtf" 
