cls

#This program is to take user input and add either BB-, OT-, or SB- to the begining of the file name




$parentFolder = "C:\test"
$subFolder = Read-Host "Please Enter the Input Location"
$InputLocation = "$parentFolder\$subFolder"

Write-Host -Separator `n
$choice = Read-Host "Is the second category OT or SB?"

if($choice.ToUpper() -eq "OT"){
    Try{
     
        Write-Host -Separator `n
        [int]$EndBB = Read-Host "Please enter the last image number for the BB's" -ErrorAction Stop
        Write-Host -Separator `n
        [int]$EndOT = Read-Host "Please enter the last image number for the OT's" -ErrorAction Stop
    }
    Catch [System.Management.Automation.ArgumentTransformationMetadataException]
    {

    
        Write-Host -Separator `n
        Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
        Write-Host -Separator `n
        Write-Host "You have entered a non numeric symbol.  Please rerun the script and enter in a number"

    }

    Try{
        $files = Get-ChildItem -path $InputLocation -filter "*.tif" -ErrorAction Stop
        $WrongFiles = Get-ChildItem -path $InputLocation -Exclude "*.tif" -ErrorAction Stop
    
    }
    Catch [System.Management.Automation.ItemNotFoundException]
    {
        Write-Host -Separator `n
        Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
        Write-Host -Separator `n
        Write-Host "Incorrect File Path, Please re-run the program with a correct file path"
    }#end catch
    Finally
    {
       Write-Host -Separator `n
   
    }#end of finally




    if($EndBB -gt 0 -and $EndBB -lt 550){

        if($EndOT -ge $EndBB -and $EndOT -lt 550){


        foreach($file in $files){
    
              $fileNumber = $file.BaseName.Substring(0,3)
           

          Try
          {      
             if([int]$fileNumber -lt 10){

                "{0:D2}" -f $fileNumber
              }elseif([int]$fileNumber -lt 100){

                "{0:D1}" -f $fileNumber
                }



    
              if([int]$fileNumber -le $EndBB){
   

                      $name = $file.BaseName
    
                      $name = "BB-" + $name + ".tif"

                      Rename-Item $file.FullName $name

                  }elseif([int]$fileNumber -le $EndOT){

                     $name = $file.BaseName
    
                     $name = "OT-" + $name + ".tif"
                     Rename-Item $file.FullName $name


                 }else{

                    
                     $name = $file.BaseName
    
                     $name = "SB-" + $name + ".tif"
                     Rename-Item $file.FullName $name

                  }
          }#end of try
          Catch #will catch System.Management.Automation.RuntimeException
          {

    
                 Write-Host -Separator `n
                 Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
                 Write-Host -Separator `n
                 Write-Host "The File that casued this error did not start with a number"
                 Write-Host -Separator `n
                 Write-Host "The program cannot convert the first 3 characters of that file to an integer" 

          }#end of catch

         }#end for each
        }#end of OT if statement 
        else{

            Write-Host "The value for EndOT is not in the required scope.  Please re-run the script and re-enter the numbers in"
        }
    }#end of if statement
    else{

            Write-Host "The value for EndBB is not in the required scope.  Please re-run the script and re-enter the numbers in"

        }
}elseif($choice.ToUpper() -eq "SB"){#ENd of choice if for OT


    Try{
     
        Write-Host -Separator `n
        [int]$EndBB = Read-Host "Please enter the last image number for the BB's" -ErrorAction Stop
        Write-Host -Separator `n
        [int]$EndSB = Read-Host "Please enter the last image number for the SB's" -ErrorAction Stop
    }
    Catch [System.Management.Automation.ArgumentTransformationMetadataException]
    {

    
        Write-Host -Separator `n
        Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
        Write-Host -Separator `n
        Write-Host "You have entered a non numeric symbol.  Please rerun the script and enter in a number"

    }

    Try{
        $files = Get-ChildItem -path $InputLocation -filter "*.tif" -ErrorAction Stop
        $WrongFiles = Get-ChildItem -path $InputLocation -Exclude "*.tif" -ErrorAction Stop
    
    }
    Catch [System.Management.Automation.ItemNotFoundException]
    {
        Write-Host -Separator `n
        Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
        Write-Host -Separator `n
        Write-Host "Incorrect File Path, Please re-run the program with a correct file path"
    }#end catch
    Finally
    {
       Write-Host -Separator `n
   
    }#end of finally




    if($EndBB -gt 0 -and $EndBB -lt 1000){

        if($EndSB -ge $EndBB -and $EndSB -lt 1000){


        foreach($file in $files){
    
              $fileNumber = $file.BaseName.Substring(0,3)
           

          Try
          {      
             if([int]$fileNumber -lt 10){

                "{0:D2}" -f $fileNumber
              }elseif([int]$fileNumber -lt 100){

                "{0:D1}" -f $fileNumber
                }



    
              if([int]$fileNumber -le $EndBB){
   

                      $name = $file.BaseName
    
                      $name = "BB-" + $name + ".tif"

                      Rename-Item $file.FullName $name

                  }elseif([int]$fileNumber -le $EndOT){

                     $name = $file.BaseName
    
                     $name = "SB-" + $name + ".tif"
                     Rename-Item $file.FullName $name


                 }else{

                    
                     $name = $file.BaseName
    
                     $name = "OT-" + $name + ".tif"
                     Rename-Item $file.FullName $name

                  }
          }#end of try
          Catch #will catch System.Management.Automation.RuntimeException
          {

    
                 Write-Host -Separator `n
                 Write-Host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Green 
                 Write-Host -Separator `n
                 Write-Host "The File that casued this error did not start with a number"
                 Write-Host -Separator `n
                 Write-Host "The program cannot convert the first 3 characters of that file to an integer" 

          }#end of catch

         }#end for each
        }#end of OT if statement 
        else{

            Write-Host "The value for EndSB is not in the required scope.  Please re-run the script and re-enter the numbers in"
        }
    }#end of if statement
    else{

            Write-Host "The value for EndBB is not in the required scope.  Please re-run the script and re-enter the numbers in"

        }

}#ENd of choice if for SB

foreach($wrongfile in $WrongFiles){

    Write-Host "File" $wrongfile.Name "is not a tif and will not work with this program"


}
