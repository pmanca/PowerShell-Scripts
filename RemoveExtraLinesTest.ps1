cls

function Refresh-ListView {
	param ([string]$path)
	$script:previousItem = (Get-Item $path).PSParentPath
	$listView1.Items.clear()
	$counter=0
	Get-ChildItem $path | % {
		$listView1.Items.Add($_.name)
		if ($_.PSIsContainer) {
			$listView1.Items[$counter].ImageIndex = 0
			$listView1.Items[$counter].Tag = "Folder"
		} else {
			$listView1.Items[$counter].ImageIndex = 1
			$listView1.Items[$counter].Tag = "File"
		} 
			$listView1.Items[$counter].Name = $_.FullName
			$counter += 1
	}
	$form1.Refresh()
}

function CustomInputBox
{
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
 [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 $userForm = New-Object System.Windows.Forms.Form
 $userForm.Text = "Create Folder"
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
 $userLabel.Text = "Please Enter the Full location of the New Folder"
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

#Generated Form Function
function GenerateForm1 {


#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$button2 = New-Object System.Windows.Forms.Button
$button1 = New-Object System.Windows.Forms.Button
$button3 = New-Object System.Windows.Forms.Button
$listView1 = New-Object System.Windows.Forms.ListView
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects



#region ImageList for nodes
$global:imageList = new-Object System.Windows.Forms.ImageList
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 32
$System_Drawing_Size.Height = 32
$global:imageList.ImageSize = $System_Drawing_Size
$image1 = [System.Drawing.Image]::FromFile("M:\Powershell\ico files\folder.ico")
$image2 = [System.Drawing.Image]::FromFile("M:\Powershell\ico files\file.ico")

$global:imageList.Images.Add("folder",$image1)
$global:imageList.Images.Add("file",$image2)
#endregion

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$button1_OnClick= 
{
	if ($script:previousItem) {
		Refresh-ListView $script:previousItem
	} else {
		[System.Windows.Forms.MessageBox]::Show("Nothing to go back")
	}
}

$doubleClick= 
{
	if ($listView1.SelectedItems[0].tag -eq "File") {
		[System.Windows.Forms.MessageBox]::Show("You double clicked a file")
        
	} else {
		Refresh-ListView $listView1.SelectedItems[0].Name
	}
}

$button2_OnClick= 
{
	$form1.Close()
}

$OnLoadForm_StateCorrection=
{
	$form1.WindowState = $InitialFormWindowState
	$listView1.LargeImageList = $imageList
	Refresh-ListView "c:\"
}

$button3_OnClick=
{
    if($listView1.SelectedItems[0].tag -eq "Folder"){
        $Script:path =  $listView1.SelectedItems[0].Name.ToString()
        $form1.Close()
    }
}

#----------------------------------------------
#region Generated Form Code
$form1.Text = "Windows Browser"
$form1.Name = "form1"
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 689
$System_Drawing_Size.Height = 499
$form1.ClientSize = $System_Drawing_Size

$button2.TabIndex = 2
$button2.Name = "button2"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button2.Size = $System_Drawing_Size
$button2.UseVisualStyleBackColor = $True

$button2.Text = "Close"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 602
$System_Drawing_Point.Y = 459
$button2.Location = $System_Drawing_Point
$button2.DataBindings.DefaultDataSourceUpdateMode = 0
$button2.add_Click($button2_OnClick)

$form1.Controls.Add($button2)

$button1.TabIndex = 1
$button1.Name = "button1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button1.Size = $System_Drawing_Size
$button1.UseVisualStyleBackColor = $True

$button1.Text = "Back"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 459
$button1.Location = $System_Drawing_Point
$button1.DataBindings.DefaultDataSourceUpdateMode = 0
$button1.add_Click($button1_OnClick)

$form1.Controls.Add($button1)

$button3.TabIndex = 3
$button3.Name = "button3"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button3.Size = $System_Drawing_Size
$button3.UseVisualStyleBackColor = $true

$button3.Text = "Choose"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 300
$System_Drawing_Point.Y = 459
$button3.Location = $System_Drawing_Point
$button3.DataBindings.DefaultDataSourceUpdateMode =0
$button3.add_Click($button3_OnClick)

$form1.Controls.Add($button3)

$listView1.UseCompatibleStateImageBehavior = $False
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 664
$System_Drawing_Size.Height = 440
$listView1.Size = $System_Drawing_Size
$listView1.DataBindings.DefaultDataSourceUpdateMode = 0
$listView1.Name = "listView1"
$listView1.View = 0
$listView1.TabIndex = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 13
$listView1.Location = $System_Drawing_Point
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 32
$System_Drawing_Size.Height = 32
$listView1.TileSize = $System_Drawing_Size

$listView1.add_DoubleClick($doubleClick)

$form1.Controls.Add($listView1)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function1

function GenerateForm2 {


#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$button2 = New-Object System.Windows.Forms.Button
$button1 = New-Object System.Windows.Forms.Button
$button3 = New-Object System.Windows.Forms.Button
$button4 = New-Object System.Windows.Forms.Button
$listView1 = New-Object System.Windows.Forms.ListView
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#region ImageList for nodes
$global:imageList = new-Object System.Windows.Forms.ImageList
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 32
$System_Drawing_Size.Height = 32
$global:imageList.ImageSize = $System_Drawing_Size
$image1 = [System.Drawing.Image]::FromFile("M:\Powershell\ico files\folder.ico")
$image2 = [System.Drawing.Image]::FromFile("M:\Powershell\ico files\file.ico")

$global:imageList.Images.Add("folder",$image1)
$global:imageList.Images.Add("file",$image2)
#endregion

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$button1_OnClick= 
{
	if ($script:previousItem) {
		Refresh-ListView $script:previousItem
	} else {
		[System.Windows.Forms.MessageBox]::Show("Nothing to go back")
	}
}

$doubleClick= 
{
	if ($listView1.SelectedItems[0].tag -eq "File") {
		[System.Windows.Forms.MessageBox]::Show("You double clicked a file")
        
	} else {
		Refresh-ListView $listView1.SelectedItems[0].Name
	}
}

$button2_OnClick= 
{
	$form1.Close()
}

$OnLoadForm_StateCorrection=
{
	$form1.WindowState = $InitialFormWindowState
	$listView1.LargeImageList = $imageList
	Refresh-ListView "c:\"
}

$button3_OnClick=
{
    if($listView1.SelectedItems[0].tag -eq "Folder"){
        $Script:path2 = $listView1.SelectedItems[0].Name.ToString()
        $form1.Close()
    }
}
$button4_OnClick=
{
    
    $pathNew = CustomInputBox
    
            
            if(Test-Path $pathNew){
                echo("Folder Already Exists")
            }
            else
            {
                New-Item -ItemType Directory -path $pathNew -Force
                echo("Folder created")
            }
             $Script:path2 = $pathNew
             $form1.Close()
            

}

#----------------------------------------------
#region Generated Form Code
$form1.Text = "Windows Browser"
$form1.Name = "form1"
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 689
$System_Drawing_Size.Height = 499
$form1.ClientSize = $System_Drawing_Size

$button2.TabIndex = 2
$button2.Name = "button2"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button2.Size = $System_Drawing_Size
$button2.UseVisualStyleBackColor = $True

$button2.Text = "Close"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 602
$System_Drawing_Point.Y = 459
$button2.Location = $System_Drawing_Point
$button2.DataBindings.DefaultDataSourceUpdateMode = 0
$button2.add_Click($button2_OnClick)

$form1.Controls.Add($button2)

$button1.TabIndex = 1
$button1.Name = "button1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button1.Size = $System_Drawing_Size
$button1.UseVisualStyleBackColor = $True

$button1.Text = "Back"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 459
$button1.Location = $System_Drawing_Point
$button1.DataBindings.DefaultDataSourceUpdateMode = 0
$button1.add_Click($button1_OnClick)

$form1.Controls.Add($button1)

$button3.TabIndex = 3
$button3.Name = "button3"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button3.Size = $System_Drawing_Size
$button3.UseVisualStyleBackColor = $true

$button3.Text = "Choose"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 200
$System_Drawing_Point.Y = 459
$button3.Location = $System_Drawing_Point
$button3.DataBindings.DefaultDataSourceUpdateMode =0
$button3.add_Click($button3_OnClick)

$form1.Controls.Add($button3)

$button4.TabIndex = 4
$button4.Name = "button4"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 75
$System_Drawing_Size.Height = 23
$button4.Size = $System_Drawing_Size
$button4.UseVisualStyleBackColor = $true

$button4.Text = "Create"

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 400
$System_Drawing_Point.Y = 459
$button4.Location = $System_Drawing_Point
$button4.DataBindings.DefaultDataSourceUpdateMode = 0
$button4.add_Click($button4_OnClick)

$form1.Controls.Add($button4)

$listView1.UseCompatibleStateImageBehavior = $False
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 664
$System_Drawing_Size.Height = 440
$listView1.Size = $System_Drawing_Size
$listView1.DataBindings.DefaultDataSourceUpdateMode = 0
$listView1.Name = "listView1"
$listView1.View = 0
$listView1.TabIndex = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 13
$listView1.Location = $System_Drawing_Point
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Width = 32
$System_Drawing_Size.Height = 32
$listView1.TileSize = $System_Drawing_Size

$listView1.add_DoubleClick($doubleClick)

$form1.Controls.Add($listView1)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function2




#Call the Function
GenerateForm1
GenerateForm2
  
  Write-Host $path
  Write-Host $path2
 
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
    #Write-Host $file

    }|Set-Content "$path2\$file"

}#end of foreach





