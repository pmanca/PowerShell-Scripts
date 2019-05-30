cls


$bad = "C:\users\pmanca.SCERIS\Errors"

$LOGfile = "C:\users\pmanca.SCERIS\TMC $(gc env:computername).log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $LOGfile -value $logstring
}


$BDFfile = "C:\Users\pmanca.SCERIS\testTMC $(get-date -f MM-dd-yyyy).bdf"

$files = gci -path "C:\Traffic_Count_Samples_for_Sceris\TMC_DEL_GAP_for_Sceris" -Exclude "*.log"

 foreach($file in $files){
    $OutputString = ""
    $OName=$file.FullName
    $Name=$file.BaseName
    
    $NewName = $Name -replace '_','|'
    
    $Pattern ="(.*)\|(\d*)\|(.*)\|(.*)\|(\d*)(.*)\|(.*)\|(\d\d)(\d\d)(\d\d\d\d)"
     
     $string = ($NewName.Split("|") | Measure-Object).count - 1

     if($string -eq 6){

        if($NewName -match $Pattern){
            if(Test-Path $BDFfile){
                echo("BDF Already Exists")
            }
            else
            {
                New-Item -ItemType file $BDFfile
            }
        $OutputString = $matches[2] + "|" + $matches[3] + "|"
        

            
           
            if($matches[4] -eq "BP"){
            
                $OutputString = $OutputString + "Boston Proper|"                             
            }
            elseif($matches[4] -eq "AB"){
            
                $OutputString = $OutputString + "Allston Brighton|"
            }
            elseif($matches[4] -eq "RX"){
                    
                $OutputString = $OutputString + "Roxbury|"
            }
            elseif($matches[4] -eq "DO"){
            
                $OutputString = $OutputString + "Dorchester|"                             
            }
            elseif($matches[4] -eq "SB"){
            
                $OutputString = $OutputString + "South Boston|"
            }
            elseif($matches[4] -eq "WR"){
            
                $OutputString = $OutputString + "West Roxbury|"
            }
            elseif($matches[4] -eq "CH"){
            
                $OutputString = $OutputString + "Charlestown|"
            }
            elseif($matches[4] -eq "EB"){

                $OutputString = $OutputString + "East Boston|"
            }
            elseif($matches[4] -eq "HP"){

                $OutputString = $OutputString + "Hyde Park|"
            }
            else{
                $OutputString = $OutputString + $matches[4] + "|"                             
            }

            $OutputString = $OutputString + $matches[5]
            
            if($matches[6] -eq "HR"){
                
                $OutputString = $OutputString + " Hours|"
                
            }
            else{
                $OutputString = $OutputString + $matches[6] + "|"
            }

            if($matches[7] -eq "TMC"){

                $OutputString = $OutputString + "Turning Movement Count|"
            }
            elseif($matches[7] -eq "DEL"){
                
                $Outputstring = $OutputString + "Intersection DELAY|"

            }
            elseif($matches[7] -eq "GAP"){

                $OutputString = $OutputString + "Intersection GAP|"

            }
            elseif($matches[7] -eq "ATR"){
                
                $OutputString = $OutputString + "Automated Traffice Recording|"

            }
            else{

                $OutputString = $OutputString + $matches[7] + "|"

            }

            $OutputString = $OName + "|" + $OutputString + $matches[8] + "/" + $matches[9] + "/" + $matches[10] + "|" + $OName + "|"

        Add-Content $BDFfile $OutputString
        LogWrite "$Oname was a success! $(get-date -f MM/dd/yyyy)"

        $OutputString

           
        }
        else{
            if(Test-Path $LOGfile){
                
                LogWrite "$Oname did not match normal file naming pattern. $(get-date -f MM/dd/yyyy)"


            }
            else
            {
                New-Item -ItemType file $LOGfile

                LogWrite "$Oname did not match normal file naming pattern. $(get-date -f MM/dd/yyyy)"
            }
            if(Test-Path $bad){

                Move-Item $Oname $bad -force
            }
            else{

                New-Item $bad -Type directory

                Move-Item $Oname $bad -force

            }
        }
      }else{
            if(Test-Path $LOGfile){
                
                LogWrite "$Oname did not match normal file naming pattern. $(get-date -f MM/dd/yyyy)"


            }
            else
            {
                New-Item -ItemType file $LOGfile

                LogWrite "$Oname did not match normal file naming pattern. $(get-date -f MM/dd/yyyy)"
            }
            if(Test-Path $bad){

                Move-Item $Oname $bad -force
            }
            else{

                New-Item $bad -Type directory

                Move-Item $Oname $bad -force

            }
        }
}




