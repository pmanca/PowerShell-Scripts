cls

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
    $userLabel1.Text = "This Program will Remove anything more than 40 lines from a txt file."
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

#call functions
IntroMessage
$path = Select-FolderDialog
SecondMessage
$path2 = Select-FolderDialog2

            if(Test-Path $path2){
                echo("Folder Already Exists")
            }
            else
            {
                New-Item -ItemType Directory -path $path2 -Force
                echo("Folder created")
            }


$files = gci -path $path -filter "*.txt"

    


foreach($file in $files){

  $lineCount = 0
   
    
    Get-Content $file.FullName |

    ForEach-Object{
    
    if($lineCount -lt 40){

    $_
    $lineCount++
    

    }
    else{
    }
    
 

    }|Set-Content "$path2\$file"

}#end of foreach
