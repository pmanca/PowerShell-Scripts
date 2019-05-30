#This script sepeartes the suffix from a last name and creates 3 columns; original, surname, suffix



$InputLocation = "C:\test\suffix test\"
$OutputLocation = "C:\test\suffix test\"

$file = gci -Path $InputLocation

$lines = Get-Content($file.FullName)|

Foreach-object{
    
    $pattern = "(.*)( )(.*)"
   
            
    if($_ -match $pattern -and $Matches[3].Length -lt 4){
        
        $a = $Matches[0]
        $b = $Matches[1]
        $c = $Matches[3]
      
      
        $output = $a + "," + $b + "," + $c
        $output
        
    }else{ 


       $e = $_
       $outputElse = $e + "," + $e
       $outputElse

    }

    }| Set-Content($OutputLocation + "Output.csv")