#Script for City of Boston to prefix each pdf in a directory 
#The Files variable will need to be adjusted for the directory
#Peter Manca 03/18/2016 ScerIS Inc.

#UPDATE for the folder that contains the LIFE files
$files = "C:\Test\Health Benefits - Life - 02012016 - Copy\"









#prefix to add to the begining of each file
$prefix = "LIFE"
#Filter to only grab PDFs
$getFiles = gci $files -Filter "*.pdf"
#Cycle through each PDF
foreach($file in $getFiles){
    #grab name of file
    $name = $file.Name
    #make the new name
    $newName = $prefix + $name

    #Rename the file
    Rename-Item -Path $file.FullName -NewName $newName


}