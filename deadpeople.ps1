cls

#23 types of information on each line
#RecordID, Lot Number, Cementery Name, SOrting letter, sorting number, site Code, Map Number, Burial Last Name, Furial First Name, Title, Year of Death, Month of Death, Day of Death, Material, type of marker, Notes, Record date, Path, SiteImage, cMOD, cDOD, cYOD, Date of Death
  


$db = "C:\test\cobdb-deadpeople.csv"

$BDFfile = "C:\test\cobdp2.bdf"

$lines = Get-Content $db 

$prevPath = "temp"


    foreach($line in $lines){
        $pattern = "(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)\|(.*)"
       
        $Outputstring = ""



        if($line -match $pattern -AND $matches[18] -eq $prevPath){
            
            $LevelTwo = $matches[8] + "|" + $matches[9] + "|" + $matches[10] + "|" + $matches[12] + "|" + $matches[13] + "|" + $matches[11] + "|"
         
           # Add-Content -path $BDFfile -value $LevelTwo 
            [IO.File]::AppendAllText($BDFfile,$leveltwo,[System.Text.Encoding]::UTF8)
            

        }elseif($line -match $pattern){

             if(Test-Path $BDFfile){
                echo("BDF Already Exists")
            }
            else
            {
         
                New-Item -ItemType file $BDFfile
            }
          
         
           $Outputstring = $matches[18] + "|L|6|~" + $matches[2] + "|" + $matches[3] + "|" + $matches[14]  + "|" + $matches[15] + "|" + $matches[16] + "|" + $matches[17] + "|Survey Sheet~|" + $matches[8] + "|" + $matches[9] + "|" + $matches[10] + "|" + $matches[12] + "|" + $matches[13] + "|" + $matches[11] + "|"


          # Add-Content $BDFfile $Outputstring
          [IO.File]::AppendAllText($BDFfile, "`r`n",[System.Text.Encoding]::UTF8)
           [IO.File]::AppendAllText($BDFfile, $Outputstring,[System.Text.Encoding]::UTF8)
           $prevPath = $matches[18]
           $prevPath
            


        }
   
    }