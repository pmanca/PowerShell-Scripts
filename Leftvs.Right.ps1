cls

$parentFolder = "C:\test"
$subFolder = Read-Host "Please Enter the Input Location"
$InputLocation = "$parentFolder\$subFolder"



Try
{
    $LeftImages = gci -path $InputLocation -filter "*_L.tif" -ErrorAction Stop
    $RightImages = gci -path $InputLocation -filter "*_R.tif" -ErrorAction stop
    $WrongFiles = gci -path $InputLocation -Exclude "*.tif" -ErrorAction Stop
    
}#end try
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
   Write-Host "End of Script Please re-run"
}#end of finally

$LeftDestination = "$InputLocation\LeftPages\"
$RightDestination = "$InputLocation\RightPages\"




foreach($file in $LeftImages){

if(!(Test-Path $LeftDestination)){

    New-Item -ItemType directory -Path $LeftDestination
    Move-Item $file.FullName -Destination $LeftDestination

}else{

    
    Move-Item $file.FullName -Destination $LeftDestination

}


}


foreach($file in $RightImages){

if(!(Test-Path $RightDestination)){
    
    New-Item -ItemType directory -Path $RightDestination
    Move-Item $file.FullName -Destination $RightDestination 

}else{

    
    Move-Item $file.FullName -Destination $RightDestination 

}

}

foreach($wrongfile in $WrongFiles){

    Write-Host "File" $wrongfile.Name "is not a tif and will not work with this program"


}



