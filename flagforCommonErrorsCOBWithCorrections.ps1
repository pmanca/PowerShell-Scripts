cls
#This program takes the output excel file that is genereated from COB.  DDLM wrote the query. then it parses it for common errors and appends a column to the end of the line

Function Message
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Flag for Errors"
    $userForm.Size = New-Object System.Drawing.Size(580,300)
    $userForm.StartPosition = "CenterScreen"
    $userForm.AutoSize = $False
    $userForm.MinimizeBox = $False
    $userForm.MaximizeBox = $False
    $userForm.SizeGripStyle= "Hide"
    $userForm.WindowState = "Normal"
    $userForm.FormBorderStyle="Fixed3D"
    #Add destination Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "The Next window will prmompt you to choose the name of the output file."
    $userForm.Controls.Add($userLabel2)
    #add button
    $CloseButton = New-Object System.Windows.Forms.Button
    $CloseButton.Location = New-Object System.Drawing.Size(230,200)
    $CloseButton.Size = New-Object System.Drawing.Size(75,23)
    $CloseButton.Text = "Close"
    $CloseButton.Add_Click({$userForm.Close()})
    $userForm.Controls.Add($CloseButton)
    #Load Form
    $userForm.Topmost = $True
    $userForm.Opacity = 0.91
    $userForm.ShowIcon = $False
    $userForm.Add_Shown({$userForm.Activate()})
    [void] $userForm.ShowDialog()
}
Function Message2
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Flag for Errors"
    $userForm.Size = New-Object System.Drawing.Size(580,300)
    $userForm.StartPosition = "CenterScreen"
    $userForm.AutoSize = $False
    $userForm.MinimizeBox = $False
    $userForm.MaximizeBox = $False
    $userForm.SizeGripStyle= "Hide"
    $userForm.WindowState = "Normal"
    $userForm.FormBorderStyle="Fixed3D"
    #Add destination Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "The Next window will prmompt you to choose the name of the BDF file to compare it to."
    $userLabel3 = New-Object System.Windows.Forms.Label
    $userLabel3.Location = New-Object System.Drawing.Size(150,200)
    $userLabel3.Size = New-Object System.Drawing.Size(300, 50)
    $userLabel3.Text = "Enter in the year and followed by BB, SB, or OT"
    $userForm.Controls.Add($userLabel2)
    $userForm.Controls.AddFunction 
}
function Custom-InputBox
{
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 $userForm = New-Object System.Windows.Forms.Form
 $userForm.Text = "Name of Output File"
 $userForm.Size = New-Object System.Drawing.Size(290,150)
 $userForm.StartPosition = "CenterScreen"
 $userForm.AutoSize = $False
 $userForm.MinimizeBox = $False
 $userForm.MaximizeBox = $False
 $userForm.SizeGripStyle= "Hide"
 $userForm.WindowState = "Normal"
 $userForm.FormBorderStyle="Fixed3D"
   
 $OKButton = New-Object System.Windows.Forms.Button
 $OKButton.Location = New-Object System.Drawing.Size(115,80)
 $OKButton.Size = New-Object System.Drawing.Size(75,23)
 $OKButton.Text = "OK"
 $OKButton.Add_Click({$global:value=$objTextBox.Text;$userForm.Close()})
 $userForm.Controls.Add($OKButton)
 $CancelButton = New-Object System.Windows.Forms.Button
 $CancelButton.Location = New-Object System.Drawing.Size(195,80)
 $CancelButton.Size = New-Object System.Drawing.Size(75,23)
 $CancelButton.Text = "Cancel"
 $CancelButton.Add_Click({$userForm.Close()})
 $userForm.Controls.Add($CancelButton)
 $userLabel = New-Object System.Windows.Forms.Label
 $userLabel.Location = New-Object System.Drawing.Size(10,20)
 $userLabel.Size = New-Object System.Drawing.Size(280,20)
 $userLabel.Text = "Please Enter the name of the output file (No Extension)"
 $userForm.Controls.Add($userLabel)
 $objTextBox = New-Object System.Windows.Forms.TextBox
 $objTextBox.Location = New-Object System.Drawing.Size(10,40)
 $objTextBox.Size = New-Object System.Drawing.Size(260,20)
 $objTextBox.Text=""
 $userForm.Controls.Add($objTextBox)
 $userForm.Topmost = $True
 $userForm.Opacity = 0.91
 $userForm.ShowIcon = $False
 $userForm.Add_Shown({$userForm.Activate(); $objTextBox.Focus()})
 [void] $userForm.ShowDialog()
 return $global:value

}
function Custom-InputBox2
{
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 $userForm = New-Object System.Windows.Forms.Form
 $userForm.Text = "Name of COB Corrections File"
 $userForm.Size = New-Object System.Drawing.Size(290,150)
 $userForm.StartPosition = "CenterScreen"
 $userForm.AutoSize = $False
 $userForm.MinimizeBox = $False
 $userForm.MaximizeBox = $False
 $userForm.SizeGripStyle= "Hide"
 $userForm.WindowState = "Normal"
 $userForm.FormBorderStyle="Fixed3D"
   
 $OKButton = New-Object System.Windows.Forms.Button
 $OKButton.Location = New-Object System.Drawing.Size(115,80)
 $OKButton.Size = New-Object System.Drawing.Size(75,23)
 $OKButton.Text = "OK"
 $OKButton.Add_Click({$global:value=$objTextBox.Text;$userForm.Close()})
 $userForm.Controls.Add($OKButton)
 $CancelButton = New-Object System.Windows.Forms.Button
 $CancelButton.Location = New-Object System.Drawing.Size(195,80)
 $CancelButton.Size = New-Object System.Drawing.Size(75,23)
 $CancelButton.Text = "Cancel"
 $CancelButton.Add_Click({$userForm.Close()})
 $userForm.Controls.Add($CancelButton)
 $userLabel = New-Object System.Windows.Forms.Label
 $userLabel.Location = New-Object System.Drawing.Size(10,20)
 $userLabel.Size = New-Object System.Drawing.Size(280,20)
 $userLabel.Text = "Please Enter the name of the COB Corrections file (No extension)"
 $userForm.Controls.Add($userLabel)
 $objTextBox = New-Object System.Windows.Forms.TextBox
 $objTextBox.Location = New-Object System.Drawing.Size(10,40)
 $objTextBox.Size = New-Object System.Drawing.Size(260,20)
 $objTextBox.Text=""
 $userForm.Controls.Add($objTextBox)
 $userForm.Topmost = $True
 $userForm.Opacity = 0.91
 $userForm.ShowIcon = $False
 $userForm.Add_Shown({$userForm.Activate(); $objTextBox.Focus()})
 [void] $userForm.ShowDialog()
 return $global:value

}
Function Convert-Delimiter([regex]$from,[string]$to)
    {
       begin
       {
          $z = [char](222)
       }
       process
       {
          $_ = $_.Trim()
          $_ = $_ -replace "(?:`"((?:(?:[^`"]|`"`"))+)(?:`"$from|`"`$))|(?:$from)|(?:((?:.(?!$from))*.)(?:$from|`$))","$z`$1`$2$z$to"
          $_ = $_ -replace "$z(?:$to|$z)?`$","$z"
          $_ = $_ -replace "`"`"","`"" -replace "`"","`"`""
          $_ = $_ -replace "$z((?:[^$z`"](?!$to))+)$z($to|`$)","`$1`$2"
          $_ = $_ -replace "$z","`"" -replace "$z","`""
          $_
       }
    }


$files = gci "\\hyperion\CoB_BR\Source_To_Be_Processed\" -filter "*.xls*"




foreach($file in $files){
write-host $file

$xlCSV = 6
$CSVfilename = [io.path]::ChangeExtension($file.FullName,"csv")
$Excel = New-Object -comobject Excel.Application
$Excel.Visible = $False
$Excel.displayalerts=$False
$Workbook = $Excel.Workbooks.Open($file.FullName)
$objWorksheet = $Workbook.Worksheets.Item(1) 
[void]$objWorksheet.Cells.Item(1, 1).EntireRow.Delete() # Delete the first row
$objRange = $objWorksheet.UsedRange 
$objRange2 = $objworksheet.Range("E1") 
[void] $objRange.Sort($objRange2) 

$Workbook.SaveAs($CSVfilename,$xlCSV)
$Excel.Quit()
 Write-Host $CSVfilename

}

$filesCSV = gci "\\hyperion\CoB_BR\Source_To_Be_Processed\" -filter "*.csv"


foreach($file in $filesCSV){
    Write-Host $file
    $bdfFile = [io.path]::ChangeExtension($file.FullName, "bdf")
    
    Get-Content $file.FullName | Convert-Delimiter "," "|" | Set-Content $bdfFile

   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"`"", "qqqq"} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "`"", ""} | Set-Content $bdfFile
   (Get-Content $bdfFile) | Foreach-Object {$_ -replace "qqqq", "`""} | Set-Content $bdfFile
   (Get-Content $bdfFile) | ForEach-Object {$_ -replace "`"", ""} | Set-Content $bdfFile #Not usually in the conversion file.  
   Write-Host $bdfFile
}
   


$logFile = "C:\test\flag3Log.txt"
function LogWrite{

    param([string]$logstring)

    Add-Content -Value $logstring -Path $logFile


}
$filesBDF = gci -Path "\\hyperion\CoB_BR\Source_To_Be_Processed\" -filter "*.bdf"

$lineCount = 0
$pattern0 = "\|----\|"
$pattern1 = "\|.*lvl.*\|"
$pattern2 = "\|.*homoeo.*\|"
$pattern3 = "\|.*\*.*\|"
$pattern4 = "\|.*`".*\|"
$pattern5a = "\|\w*\|"
$pattern5b = "\|\d*\|"
$pattern6a = "\|.*\d\|"
$pattern6b = "\|.*\w\|"
$pattern6c = "\|.*.\|"
$pattern7a = "\|\s.*\|"
$pattern7b = "\|.*\s\|"
$pattern8a = "\|.*\sI.*\|"
$pattern8b = "\|.*I\s.*\|"
$pattern9a = "\|.*MAC\s.*\|"
$pattern9b = "\|.*Mc\s.*\|"
$pattern10 = "\|.*\w[A-Z]\d\w[A-Z].*\|"
$pattern11 = "^.*\|.*\|.*\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|$"
$pattern12 = "^(\d{1,2}/\d{1,2}/\d{4})\|(\d{4})\|(.*)\|(.*)\|(\d{5})\|"
$temp = "Archive Date|1. Volume Year|2. Record Type|3. Deposition Number|4. Record Number|5. DoB|6. Child First Name|7. Child Middle Name|8. Child Last Name|9. Sex|10. Father First Name|11. Father Middle Name|12. Father Last Name|13. Mother First Name|14. Mother Middle Name|15. Mother Maiden Name|16. Physician|17. PoB Street|18. PoB City|19. PoB State|20. PoB Country|21. Residence Of Parents|22. Occupation Of Father|23. Birthplace Of Father|24. Birthplace Of Mother|25. Date Of Record|26. Race|27. Restricted Record|28. Delayed Record|29. Questionable Fields|30. Flag1|Flag2|Flag3|"


foreach($file in $filesBDF){

$tempRecordNumber = 0
Message
Custom-InputBox
Try{
    $file2 = "\\hyperion\CoB_BR\To_Review\$value.bdf"
}catch{
     
    Write-Host -Separator `n
    Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
    Write-Host -Separator `n
    Write-Host "You have entered a file name that does not exist.  Please rerun the script."
}
Add-Content -value $temp -Path $file2
Get-Content $file.FullName |


ForEach-Object{
    $lineCount++
    $errorCount = 0    
        $_ = $_ -replace "StillBirth", "StillBorn"
        $childLastName = $_.Split('|')[8]
        $FatherLastName = $_.Split('|')[12]
        $childLastNameS = $childLastName.Split(' ')[0]
        if($ChildLastNameS -ne $FatherLastName){
            if($errorCount -eq 0){
                $temp = $_ + "Last Name mismatch|"
            }else{
                $temp = $temp + "Last Name mismatch|"
            }
        }  
        if($_ -match $pattern1){
            #LogWrite "lvl - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"lvl|"
            }else{
                $temp = $temp + "lvl|"
            }
            $errorCount++
        }
        if($_ -match $pattern2){
           # LogWrite "homoeo - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"homoeo|"
            }else{
                $temp = $temp+"homoeo|"
            }
            $errorCount++
        }
        if($_ -match $pattern3){
           # LogWrite "* - $lineCount"
            if($errorCount -eq 0){   
                $temp = $_+"* found|"
            }else{
                $temp = $temp+"* found|"
            }
            $errorCount++
        }
        if($_ -match $pattern4){
           # LogWrite "`" found - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"`" found|"
            }else{
                $temp = $temp+"`" found|"
            }
            $errorCount++
        }
        if($_ -notmatch $pattern5a  -and $_ -notmatch $pattern5b -and $_ -notmatch $pattern0){
            #LogWrite "does not start with char/num - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"does not start with char/num|"
            }else{
                $temp = $temp+"does not start with char/num|"
            }
            $errorCount++
        }
        if($_ -notmatch $pattern6a -and $_ -notmatch $pattern6b -and $_ -notmatch $pattern6c -and $_ -notmatch $pattern0){
           # LogWrite "not end properly - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"not end properly(.,\w,\d)|"
            }else{
                $temp = $temp+"not end properly(.,\w,\d)|"
            }
            $errorCount++
        }
        if($_ -match $pattern7a -and $_ -match $pattern7b){
           # LogWrite "Leading/trailing \s - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"Leading/trailing space|"
            }else{
                $temp = $temp+"Leading/trailing space|"
            }
            $errorCount++
        }
        #if($_ -match $pattern8a -or $_ -match $pattern8b){
           # LogWrite "\sI or I\s - $lineCount"
          #  if($errorCount -eq 0){
          #      $temp = $_+"space around I|"
          #  }else{
           #     $temp = $temp+"space around I|"
           # }
           # $errorCount++            
        #}
        if($_ -match $pattern9a -and $_ -match $pattern9b){
           # LogWrite "Mac/MC - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"Space after MAc/MC|"
            }else{
                $temp = $temp+"Space after MAC/MC|"
            }
            $errorCoount++
        }
        if($_ -match $pattern10){
           # LogWrite "char to num - $lineCount"
            if($errorCount -eq 0){
                $temp = $_+"char to num|"
            }else{
                $temp = $temp+"char to num|"    
            }
            $errorCount++
        }
        if($_ -match $pattern12){
            
            if(([int]$Matches[5] - $tempRecordNumber) -ne 1){
            if($errorCount -eq 0){    
                $temp = $_+"Sequence Error|"
            }else{
                $temp = $temp +"Sequence Error|"
            }
                $errorCount++
            }   
            $tempRecordNumber = [int]$Matches[5]
            
        }
        if($_ -match $pattern11){
            
        
        
        
        }elseif($errorCount -eq 0){
            $temp = $_+"|"
            Add-Content -value $temp -path $file2
        
        }else{
            Add-Content -value $temp -Path $file2
        }
        
        
        Write-Host $lineCount

}
}
$files2Move = gci "\\hyperion\CoB_BR\Source_To_Be_Processed\"
foreach($file in $files2Move){
    Move-Item -Path $file.FullName -Destination "\\hyperion\CoB_BR\Source_Processed\" -Force
} 


$files = gci "\\hyperion\CoB_BR\To_Review" -Filter "*.bdf"

foreach($file in $files){
    Message2
    Custom-InputBox2
    $BDF = $value 
    Try{
        $file2 = gci "\\hyperion\CoB_BR\COB Corrections\$BDF.bdf"
    }catch{
     
        Write-Host -Separator `n
        Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
        Write-Host -Separator `n
        Write-Host "You have entered a file name that does not exist.  Please rerun the script."
    }
    $lineFileCount = 0
    $lineFile2Count = 0
    $pattern = "^.*\|\d{4}\|.*\|.*\|(\d{5})\|.*"
    $pattern2 = "^(.*)\|(.*)\|(.*)\|(\d*)$"
    $logfile = "\\hyperion\COB_BR\To_Review\$BDF FinalWithReview.bdf"
    $temp = "Archive Date|1. Volume Year|2. Record Type|3. Deposition Number|4. Record Number|5. DoB|6. Child First Name|7. Child Middle Name|8. Child Last Name|9. Sex|10. Father First Name|11. Father Middle Name|12. Father Last Name|13. Mother First Name|14. Mother Middle Name|15. Mother Maiden Name|16. Physician|17. PoB Street|18. PoB City|19. PoB State|20. PoB Country|21. Residence Of Parents|22. Occupation Of Father|23. Birthplace Of Father|24. Birthplace Of Mother|25. Date Of Record|26. Race|27. Restricted Record|28. Delayed Record|29. Questionable Fields|30. Flag1|Flag2|Flag3|"
    function LogWrite{

        param([string]$logstring)
        Add-Content -Value $logstring -path $logfile 

    }
    LogWrite $temp
    Get-Content $file.FullName|

    ForEach-Object{
        $lineFileCount++
        if($_ -match $pattern){
        [int]$RN = $Matches[1]
        Write-Host $RN
        $temp = $_
        $bool1 = $false
        $bool2 = $false
            Get-Content $file2.FullName|
    
            ForEach-Object{
    
            $lineFile2Count++
                    if($_ -match $pattern2){
                        [int]$RN2 = $Matches[4]
                        $fixed = $Matches[2]
                        $correct = $Matches[1]
                        $UDI = $Matches[3]
                        if($RN -eq $RN2){
                           if($bool2 -eq $false){
                                if($fixed -eq "`""){}else{
                                    $temp = $temp + "COB Reviewed($fixed,$correct,$UDI)"
                                    Write-Host $temp

                                    LogWrite $temp 
                                    $bool1 = $true
                                    $bool2 = $true
                                    }
                           }
                        }
                    
            
                    }else{
                        LogWrite $temp
                
                    }
            

    
            }

            if($bool1 -eq $false){

            LogWrite $_
            }

        }



    }
   
}
