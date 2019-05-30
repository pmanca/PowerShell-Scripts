#########################################################################################
#  Project:     Service Center / Client: Pioneer
#  Summary:     Load files from client for ODBC lookups in ScerIS Repository
#               Project coincides with Service Center upgrade to lynx2
#  Assumptions: Files are formatted according to the $pattern* variables
#
#  Authors:     Peter Manca, Eamon Pac
#  Date:        07/01/2015
#########################################################################################  


#Clear PowerShell screen
Clear-Host



##########################################################################################
#  Functions
##########################################################################################

##  Message windows  ##

function IntroMessageACH     # Prompt user for ACH file input
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Load Pioneer File - ACH"
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
    $userLabel1.Text = "This Program will load a file for Pioneer ACH."
    $userForm.Controls.Add($userLabel1)
    #Add direction Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "Choose a file in Windows Explorer after closing this dialog box"
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

function IntroMessageAP      # Prompt user for AP file input
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Load Pioneer File - AP"
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
    $userLabel1.Text = "This Program will load a file for Pioneer AP."
    $userForm.Controls.Add($userLabel1)
    #Add direction Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "Choose a file in Windows Explorer after closing this dialog box"
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

function IntroMessageWires   # Prompt user for AP file input
{
    #Message to prompt the user to explain how the program works.  
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    $userForm = New-Object System.Windows.Forms.Form
    $userForm.Text = "Load Pioneer File - Wires"
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
    $userLabel1.Text = "This Program will load a file for Pioneer Wires."
    $userForm.Controls.Add($userLabel1)
    #Add direction Label
    $userLabel2 = New-Object System.Windows.Forms.Label
    $userLabel2.Location = New-Object System.Drawing.Size(150,100)
    $userLabel2.Size = New-Object System.Drawing.Size(300,50)
    $userLabel2.Text = "Choose a file in Windows Explorer after closing this dialog box"
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


##  Select File for Uploads  ##

function Select-FileDialog # Function to choose file in windows explorer
{
	param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	$objForm = New-Object System.Windows.Forms.OpenFileDialog
	$objForm.InitialDirectory = $Directory
	$objForm.Filter = $Filter
	$objForm.Title = $Title
	$Show = $objForm.ShowDialog()
	If ($Show -eq "OK")
	{
		Return $objForm.FileName
        
	}
	Else
	{
		Write-Error "Operation cancelled by user."
	}
}

###########################################################   End of Functions   #########



##########################################################################################
#  Variables
##########################################################################################

##  USER VARIABLES - Set server and database where SQL tables reside ## 
$server    = "gemini1"
$database  = "SVCScerISProduction2"
$logFile   = "\\lynx2\Customers\Pioneer\Database Import\Log.txt"


$date      = Get-Date -Format g   # Current date for log file time stamp


## Server and Database used for connections and insert statements
$connectionString = "server='$server';database='$database';trusted_connection=true; integrated security=SSPI"
$connection       = New-Object System.Data.SQLClient.SQLConnection($connectionString)

###########################################################   End of Variables   #########



##########################################################################################
#  AP Job
##########################################################################################

# Call functions to inform the user which file to select
IntroMessageAP
$fileAP  = Select-FileDialog

# Pattern (regex) that ACH file is received in. Eight fields, each separated by |
$patternAP = "^(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)$"

# Pipe data out of file, process content as array, assign array positions to fields in SQL table    
Get-Content -path $fileAP | ForEach-Object{
   
    if($_ -match $patternAP){
        $checkNumber          = $matches[1]
        $vendorName           = $matches[2]
        $voucherID            = $matches[3]
        $invoiceNumber        = $matches[4]
        $paymentDate          = $matches[5]
        $checkAmount          = $matches[6]
        $vendorClassification = $matches[7]
        $def                  = $matches[8]
        
        # Replace ' with '' for SQL insert
        $vendorName           = $vendorName           -replace "\'","''"
        $vendorClassification = $vendorClassification -replace "\'","''"
		$invoiceNumber        = $invoiceNumber        -replace "\'","''"
    
    }else{
        Write-Host "no match" $_
    }
    
    Try {
        
        $connection.Open()
        $sql_insert = "INSERT INTO PioneerAP VALUES ('$checkNumber','$vendorName','$voucherID','$invoiceNumber','$paymentDate','$checkAmount','$vendorClassification','$def')"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($sql_insert, $connection) 
        $cmd.ExecuteNonQuery()
        
    
    }catch{
        [System.exception]
        Write-Host $sql_insert
        $errorMessage = $_.Exception.Message
        $errorItem    = $_.Exception.ItemName
        Add-Content $logFile ($date + $errorMessage + $errorItem + $fileAP + $sql_insert)
    
    }Finally {
        $connection.Close()
    }  
}

#####################################################################   End AP   #########



##########################################################################################
#  ACH Job
##########################################################################################

# Call functions to inform the user which file to select   
IntroMessageACH
$fileACH  = Select-FileDialog

# Pattern (regex) that ACH file is received in. Eight fields, each separated by |
$patternACH = "^(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)$"
  

# Pipe data out of file, process content as array, assign array positions to fields in SQL table    
Get-Content -path $fileACH | ForEach-Object{
    
    if($_ -match $patternACH){
    #Write-Host $matches[7]
        $checkNumber          = $matches[1]
        $vendorName           = $matches[2]
        $referenceNumber      = $matches[3]
        $invoiceNumber        = $matches[4]
        $checkDate            = $matches[5]
        $checkAmount          = $matches[6]
        $vendorClassification = $matches[7]
        $bankCode             = $matches[8]

        # Replace ' with '' for SQL insert
        $vendorName           = $vendorName 	-replace "\'","''"
		$checkDate            = $checkDate  	-replace "\'","''"
		$invoiceNumber        = $invoiceNumber  -replace "\'","''"
    
    }else{
        Write-Host "no match" $_
    }
    
    Try {
        $connection.Open()
        $sql_insert = "INSERT INTO PioneerACH VALUES ('$checkNumber','$vendorName','$referenceNumber','$invoiceNumber','$checkDate','$checkAmount','$vendorClassification','$bankCode')"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($sql_insert, $connection) 
        $cmd.ExecuteNonQuery()
    
    }catch{

        [System.exception]
        Write-Host $sql_insert
        $errorMessage = $_.Exception.Message
        $errorItem    = $_.Exception.ItemName
        Add-Content $logFile ($date + $errorMessage + $errorItem + $fileAP + $sql_insert)
    
    }Finally {

        $connection.Close()

    }  
}

#####################################################################   End ACH  #########



##########################################################################################
#  Wires Job
##########################################################################################

# Call functions to inform the user which file to select   

IntroMessageWires
$fileWires  = Select-FileDialog

# Pattern (regex) that ACH file is received in. Nine fields, each separated by |
$patternWires = "^(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)$"

# Pipe data out of file, process content as array, assign array positions to fields in SQL table     
Get-Content -path $fileWires | ForEach-Object{
    
    if($_ -match $patternWires){

    #Write-Host $matches[7]
        $bankName             = $matches[1]
        $beneficiaryAcctNumber= $matches[2]
        $busUnitWiredFrom     = $matches[3]
        $currency             = $matches[4]
        $wireAmount           = $matches[5]
        $voucherID            = $matches[6]
        $vendorName           = $matches[7]
        $bankCode             = $matches[8]
        $checkNumber          = $matches[9]

        # Replace ' with '' for SQL insert
        $bankName             = $bankName -replace "\'","''"
        $vendorName           = $vendorName -replace "\'","''"
    
    }else{

        Write-Host "no match" $_

    }
    
    Try {

        $connection.Open()
        $sql_insert = "INSERT INTO PioneerWires VALUES ('$bankName','$beneficiaryAcctNumber','$busUnitWiredFrom','$currency','$wireAmount','$voucherID','$vendorName','$bankCode','$checkNumber')"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($sql_insert, $connection) 
        $cmd.ExecuteNonQuery()
    
    }catch{

        [System.exception]
        Write-Host $sql_insert
        $errorMessage = $_.Exception.Message
        $errorItem    = $_.Exception.ItemName
        Add-Content $logFile ($date + $errorMessage + $errorItem + $fileAP + $sql_insert)
    
    }Finally {

        $connection.Close()

    }  
}

#####################################################################   End Wires  #######