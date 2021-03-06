$InputLocation = "M:\test"
$OutputLocation = "M:\test\output"
#Get all GTO files from InputLocation
$files = get-childitem -filter *.gto -path $InputLocation

Foreach ($file in $files) {
               
    $pattern = "\d\d\d[2-9]"
    $found=$false

	#Get full content for current file
    $lines = Get-Content($file.FullName)|
    
    Foreach-object{ 
		#Get line content for AssignedToUserID zone
		if($_ -match "AssignedToUserID-TZ"){
			$a = $_
		}
		
		#Get line content for EFormID zone
		if($_ -match "EFormID-TZ"){
			$b = $_ 
		}        
		
		#Check for page number line <> 0001
		if($_ -match "DS_PGSEQ-DC:$pattern"){
			if($found -eq $false){
				$found=$true
			}
		}else{
			$found=$false
		}

		#If a page number line is found (other than 0001) then write out page number line($_), AssignedTOUserID($a) and EFormID($b)
		if($found -eq $true){
			$_
			$a
			$b
		}       
		   
		if($found -ne $true){
			#If not a page number line (or is a page number line = 0001) then just write out original line
			$_
		}
    }| Set-Content($OutputLocation + "\" + $file.Name) #Output new file content to OutputLocation
}
      


  
  
