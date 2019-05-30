cls
#This Script for the COB project counts the total number of characters in a Year.  
#outputs the number of files processed, input location, total character count.  

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
    $userLabel1.Text = "This Program will count the total number of characters in the files processed"
    $userForm.Controls.Add($userLabel1)
    #Add direction Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "The windows Explorer will allow you to choose the folder where the txt files are located"
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

IntroMessage
$input = Select-FolderDialog
SecondMessage
$outPath = Select-FolderDialog2
$files = gci -path $input -filter "*.txt"
$patterYear = ".*(\d{4}-Volume\d)"
if($input -match $patterYear){
Write-Host $Matches[1]
$NewFile = $Matches[1]
}

$filecount = 0
$totalChar = 0

foreach($file in $files){
    
    $filecount++
    $linecount = 0
    
    Get-Content $file.FullName|
    
        foreach-object{
            $linecount++
            if($linecount -ne 1){


                #sample line below
                #|1921|Boston Birth|----|1|01/01/1921|GEORGE|HOWARD|ALLEN|M|MILTON|E|ALLEN|MYRTLE|----|ORR|W H SAWYER|RESTHAVEN HOSPITAL|BOSTON|----|----|BROOKLINE|AUTO SALESMAN|NORTHAMPTON|NEW BRUNSWICK|01/03/1921|----|N|N|11,|Y|1|2|
          
                [regex] $pattern = "(^\|\d{4}\|.*\|.*\|)(\d{1,5})(\|.*\|\d\|\d\|$)"
                if($_ -match $pattern)
                {



              
                       $lineChar =  ($_.Length - (Select-String -Pattern ([regex]'\|') -InputObject $_ -AllMatches).Matches.Count - $matches[2].Length + 5)

                       $totalChar += $lineChar
         
                       #Write-Host $lineChar  " - "  $totalChar



                }




            }
        
        

    }

}
$results = @("File Count:", $filecount,"`n","Input Location:", $input,"`n", "Total Number of Characters", $totalChar)

$results|out-file "$outPath\$NewFile.txt" -force