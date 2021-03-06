#NOTE 4/12/2016
<#Kevin infromed me that the 7zip process takes the whole Batches Ready To Uplodad folder and drops it off on the ftp server
He is going to get back to me on if i need to updated this script.

#>




$Error.clear()
$Debug = 0

cls
$BDFPath = "\\lynx2\Customers\MTF\Indexed Batches - BDF\"
$OutputPath = "\\lynx2\Customers\MTF\Batches Ready To Upload\"
$ImagePath = $OutputPath + "Images\"
$Files = gci "$BDFPath\*.txt*"
$AnyDocFiles = gci "$BDFPath\*.anydoc*"
$Pattern1 = "\\\\lynx2\\Customers\\MTF\\Indexed Batches - BDF"
$Pattern2 = "\\\\lynx2\\Customers\\MTF\\Batches Ready To Upload"

$MTFPath = "E:\edi\sceris\input\images"

#Function to clean up input files. Used throughout script as part of each Catch block.
Function Cleanup ($d)
{
    If ($d -NE 1)
    {
        Try
        {
            Write-Host "Cleaning up input files ..."
            Remove-Item "$BDFPath*.*"
            Remove-Item "$OutputPath*.*"
            Remove-Item "$ImagePath*.*"
        }
        Catch
        {
            Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
            $msgObj = New-Object -ComObject wscript.shell
            $msg = $msgObj.popup("$Error",0,"Error",1)
            $Error.clear()

            Exit
        }
    }
}
function Write-ZipUsing7Zip([string]$FilesToZip, [string]$ZipOutputFilePath, [string]$Password, [ValidateSet('7z','zip','gzip','bzip2','tar','iso','udf')][string]$CompressionType = 'zip', [switch]$HideWindow)
{
	# Look for the 7zip executable.
	$pathTo32Bit7Zip = "C:\Program Files (x86)\7-Zip\7z.exe"
	$pathTo64Bit7Zip = "C:\Program Files\7-Zip\7z.exe"
	$THIS_SCRIPTS_DIRECTORY = Split-Path $script:MyInvocation.MyCommand.Path
	$pathToStandAloneExe = Join-Path $THIS_SCRIPTS_DIRECTORY "7za.exe"
	if (Test-Path $pathTo64Bit7Zip) { $pathTo7ZipExe = $pathTo64Bit7Zip } 
	elseif (Test-Path $pathTo32Bit7Zip) { $pathTo7ZipExe = $pathTo32Bit7Zip }
	elseif (Test-Path $pathToStandAloneExe) { $pathTo7ZipExe = $pathToStandAloneExe }
	else { throw "Could not find the 7-zip executable." }
	
	# Delete the destination zip file if it already exists (i.e. overwrite it).
	if (Test-Path $ZipOutputFilePath) { Remove-Item $ZipOutputFilePath -Force }
	
	$windowStyle = "Normal"
	if ($HideWindow) { $windowStyle = "Hidden" }
	
	# Create the arguments to use to zip up the files.
	# Command-line argument syntax can be found at: http://www.dotnetperls.com/7-zip-examples
	$arguments = "a -t$CompressionType ""$ZipOutputFilePath"" ""$FilesToZip"" -mx9"
	if (!([string]::IsNullOrEmpty($Password))) { $arguments += " -p$Password" }
	
	# Zip up the files.
	$p = Start-Process $pathTo7ZipExe -ArgumentList $arguments -Wait -PassThru -WindowStyle $windowStyle

	# If the files were not zipped successfully.
	if (!(($p.HasExited -eq $true) -and ($p.ExitCode -eq 0))) 
	{
		throw "There was a problem creating the zip file '$ZipFilePath'."
	}
}

#Substitutes MTF filepath in BDFs produced by Repository and creates new BDFs in OutputPath location
Try
{
    Write-Host "Processing Repository BDFs ..."

    Foreach ($File in $Files){
        $FileName = $File.Name
        $FullPath = $BDFPath + $FileName
        $FileContent = get-content $FullPath  
        $OutputFile = $OutputPath + $FileName

        Foreach ($Line in $FileContent) {
            If ($Line -match $Pattern1)  {
                $Line = $Line -Replace($Pattern1, $MTFPath)|Out-File -FilePath $OutputFile -Append
            }
            Else {
                $Line|Out-File -FilePath $OutputFile -Append
            }
        }
        If ($Debug -EQ 1) {Write-Host "$FullPath processed and successfully written to $OutputFile"}
    }
}
Catch
{
    Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
    $msgObj = New-Object -ComObject wscript.shell
    $msg = $msgObj.popup("$Error",0,"Error",1)
    Cleanup $Debug
    $Error.clear()

    Exit
}

#Substitutes MTF filepath in BDFs produced by AnyDoc and creates new BDFs in OutputPath location
Try
{
    Write-Host "Processing AnyDoc BDFs ..."

    If ($AnyDocFiles.Count -GT 0) {
        Foreach ($AnyDocFile in $AnyDocFiles){
            $FileName = $AnyDocFile.Name
            $FullPath = $BDFPath + $FileName
            $FileContent = get-content $FullPath  
            $OutputFile = $OutputPath + $FileName

            Foreach ($Line in $FileContent) {
                If ($Line -match $Pattern2)  {
                    $Line = $Line -Replace($Pattern2, $MTFPath)|Out-File -FilePath $OutputFile -Append
                }
                Else {
                    $Line|Out-File -FilePath $OutputFile -Append
                }
            }
            If ($Debug -EQ 1) {Write-Host "$Fullpath processed and successfully written to $OutputFile"}
        }
    }
}
Catch
{
    Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
    $msgObj = New-Object -ComObject wscript.shell
    $msg = $msgObj.popup("$Error",0,"Error",1)
    Cleanup $Debug
    $Error.clear()

    Exit
}

#Copy all images to OutputPath\Images for inclusion in the zip file to be sent to MTF
Try
{
    Write-Host "Copying images from $Images to $ImagePath ..."

    $Images = $BDFPath + "*.tif"
    Copy -path $Images -destination $ImagePath
}
Catch
{
    Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
    $msgObj = New-Object -ComObject wscript.shell
    $msg = $msgObj.popup("$Error",0,"Error",1)
    Cleanup $Debug
    $Error.clear()

    Exit
}

#Creates zip file to be sent to MTF
Try
{
    Write-Host "Creating zip file ..."
    #Add-Type -Path "\\lynx2\Customers\MTF\Files\ICSharpCode.SharpZipLib.dll"
    #Add-Type -Path "C:\ScerIS Company Files\MTF\Powershell Testing\ICSharpCode.SharpZipLib.dll"
    
    #The old Isharp Code  was written in for when this ran on Lynx by Pat Haley
    #I re did this section becasue i couldn't get the right files to install on Lisa's
    #New machine it now uses 7-zip as the zipping application
    #I have left the commented out lines in here for legacy purposes
    #Peter Manca 9/30/2015

    
    
    #[System.Reflection.Assembly]::LoadFrom("C:\Windows\System32\ICSharpCode.SharpZipLib.dll")
   # $Zip = New-Object ICSharpCode.SharpZipLib.Zip.FastZip
    $TimeStamp = Get-Date
    $TimeStamp = $TimeStamp.ToString("MMddyyyyHHmmss")
    $ZipName = $OutputPath  + "MTF TTC Batches - $TimeStamp.zip"
    $Source = $OutputPath
    $Zip = Write-ZipUsing7Zip -FilesToZip $Source -Password "key*blue1" -CompressionType zip -ZipOutputFilePath "$ZipName" -HideWindow $true
    #$Zip.Password = "key*blue1"
    #$Zip.CreateZip($ZipName, $Source, $True, "\.tif$|\.txt$|\.anydoc$")
}

Catch
{
    Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
    $msgObj = New-Object -ComObject wscript.shell
    $msg = $msgObj.popup("$Error",0,"Error",1)
    Cleanup $Debug
    $Error.clear()

    Exit
}

#Uploads zip file to MTF's FTP server
Try
{
    Write-Host "Uploading zip file to MTF ..."
    $target = "ftp://scerftp:fizzy*14u@63.70.147.4/input/MTF TTC Batches - $TimeStamp.zip" #this appears to be the MTF ftp client -peter
    $WebClient = New-Object System.Net.WebClient
    $WebClient.UploadFile($target, $ZipName)

    Write-Host "Zip file $ZipName successfully sent to MTF"
}
Catch
{
    Write-Host "The following error has occurred: $Error" -ForegroundColor Red    
    $msgObj = New-Object -ComObject wscript.shell
    $msg = $msgObj.popup("$Error",0,"Error",1)
    Cleanup $Debug
    $Error.clear()

    Exit
}
Finally
{
    Cleanup $Debug
}



