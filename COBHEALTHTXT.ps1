#Script for COB to prefix each line in a text file with HEALTH and then
#change the extension from txt to out for the new file it is written out to  
#The File Variable will need to be adjusted for the run
#Peter Manca 3/18/2016 ScerIS Inc.

#UPDATE for whatever text file you wish to run this script against
$file = "C:\Test\Health Benefits - Health - 02012016 - Copy\Health Benefits - Health - 02032016- done.txt"




$name = $file
$name = $name -replace ".txt", ".out"

#grabs content of file
get-content $file |
#cycle through each line    
ForEach-Object{
    
    $outString = "HEALTH" + $_
    #Adds to the output file
    Add-Content -Value $outString -Path $name
}