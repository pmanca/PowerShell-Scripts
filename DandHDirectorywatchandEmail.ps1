cls
#Author: Peter Manca
#Notes: This script is planned to run from a windows task scheduler every 15 minutes and check to see if any files have gone
#into the error directory in the past 15 minutes and send an email if so. 

#DISCLAIMER:This script is being handed to Steven Kleinfelter untested and might need to be tweaked



$From = "schedadmin@dandh.com"
$To = "skleinfelter@dandh.com"
$Cc = "bschreiber@dandh.com"
$Subject = "Autorun Error Found"
$SMTPServer = "casarray.dandh.com"
$SMTPPort = "25"

$hoursToCheck = -(1/4)

##########################################################

$bdfArchiverDirectory = "\\corpwscrpd001\ScerIS\AnyDoc\OCR for AnyDoc\data\caapinv.fof\archiver\Error"
$CADirectory = "\\corpwscrpd001\ScerIS\AnyDoc\OCR for AnyDoc\data\apinvoic.fof\archiver\Error\"
$DELDirectory= "\\corpwscrpd001\ScerIS\AnyDoc\OCR for AnyDoc\deleted\"

##########################################################

$errorAnyDoctxts=@()
$CAerrorAnyDoctxts=@()
$DELerrorAnyDoctxts=@()
$errorAnyDoctxts = Get-ChildItem $bdfArchiverDirectory | Where{$_.LastWriteTime -gt (Get-Date).AddHours($hoursToCheck)}
$CAerrorAnyDoctxts = Get-ChildItem $CADirectory | Where{$_.LastWriteTime -gt (Get-Date).AddHours($hoursToCheck)}
$DELerrorAnyDoctxts = Get-ChildItem $DELDirectory | Where{$_.LastWriteTime -gt (Get-Date).AddHours($hoursToCheck)}



##########################################################

foreach($errorFile in $errorAnyDoctxts){
    
    $errorFileName = $errorFile.FullName
    $Body = "The file $errorFileName has been found in the error directory for an Autorun Job"
    Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl
}


foreach($errorFile in $CAerrorAnyDoctxts){
    
    $errorFileName = $errorFile.FullName
    $Body = "The file $errorFileName has been found in the error directory for an Autorun Job"
    Send-MailMessage -From $From -to $To  -Cc $Cc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl
}

foreach($errorFile in $DELerrorAnyDoctxts){
    
    $errorFileName = $errorFile.FullName
    $Body = "The file $errorFileName has been found in the error directory for an Autorun Job"
    Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl
}



