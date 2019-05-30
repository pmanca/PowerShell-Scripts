cls

$parentFolder = "C:\test"
$subFolder = Read-Host "Please Enter the Input Location"
$InputLocation = "$parentFolder\$subFolder"

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
   Write-Host "End of Script"
}#end of finally


foreach($file in $files){
    
   

         $name = $file.BaseName
    
         $name = "BB-" + $name + ".tif"

         Rename-Item $file.FullName $name

}


foreach($wrongfile in $WrongFiles){

    Write-Host "File" $wrongfile.Name "is not a tif and will not work with this program"


}
