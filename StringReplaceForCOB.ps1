﻿cls


# "This Program will take a custom input pattern and replace it with a custom input string in a text file"
#THis program was written for Dave for a COB project by Peter Manca
#03/25/2014



Function IntroMessage
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Remove Extra Lines"
    $userForm.Size = New-Object System.Drawing.Size(580,300)
    $userForm.StartPosition = "CenterScreen"
    $userForm.AutoSize = $False
    $userForm.MinimizeBox = $False
    $userForm.MaximizeBox = $False
    $userForm.SizeGripStyle= "Hide"
    $userForm.WindowState = "Normal"
    $userForm.FormBorderStyle="Fixed3D"
    #add label1
    $userLabel1 = New-Object System.Windows.Forms.Label
    $userLabel1.Location = New-Object System.Drawing.Size(150,50)
    $userLabel1.Size = New-Object System.Drawing.Size(300,50)
    $userLabel1.Text = "This Program will Replace a custom input pattern  with another custom input string in a text file"
    $userForm.Controls.Add($userLabel1)
    #Add direction Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "The first windows Explorer will allow you to choose the folder where the txt files are located"
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
Function SecondMessage
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Remove Extra Lines"
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
    $userLabel2.Text = "The next windows Explorer will allow you to choose the folder where the new txt files will be saved"
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
Function ThirdMessage
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Remove Extra Lines"
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
    $userLabel2.Text = "The Next two windows will ask you to choose the pattern and the replacement string."
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

Function Select-FolderDialog
{
    param([string]$Description="Select Folder",[string]$RootFolder="Desktop")

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
     Out-Null     

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $objForm.ShowNewFolderButton = $false
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Error "Operation cancelled by user."
        }
    }
Function Select-FolderDialog2
{
    param([string]$Description="Select Folder",[string]$RootFolder="Desktop")

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
     Out-Null     

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Error "Operation cancelled by user."
        }
    }

function Custom-InputBox
{
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 $userForm = New-Object System.Windows.Forms.Form
 $userForm.Text = "Pattern Input"
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
 $userLabel.Text = "Please Enter the pattern"
 $userForm.Controls.Add($userLabel)
 $objTextBox = New-Object System.Windows.Forms.TextBox
 $objTextBox.Location = New-Object System.Drawing.Size(10,40)
 $objTextBox.Size = New-Object System.Drawing.Size(260,20)
 $objTextBox.Text=""
 $userForm.Controls.Add($objTextBox)
 $userForm.Topmost = $True
 $userForm.Opacity = 0.91
 $userForm.ShowIcon = $False
 $userForm.Add_Shown({$userForm.Activate()})
 [void] $userForm.ShowDialog()
 return $global:value

}

IntroMessage
$path = Select-FolderDialog
SecondMessage
$path2 = Select-FolderDialog2
ThirdMessage
$pattern = Custom-InputBox
$replacePattern = Custom-InputBox

if($pattern -match "|"){
    $pattern = $pattern -replace "\|", "\|"
    
}

$files = gci -path $path -filter "*.txt"


foreach($file in $files){

 

    
    Get-Content $file.FullName |

    ForEach-Object{
   
   if($_ -match $pattern){
        

             $_ -replace $pattern,$replacePattern
            
        
      }else{
        $_
        
      }

        
    
    }|Set-Content "$path2\$file"



}#end of foreach






