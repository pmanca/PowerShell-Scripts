############################################
#Getting list of folder names that are nested once.  outputs to text file
#Peter Manca 6/25/2015 going to file this under notes.  

$folders = gci "E:\Backups - for testing"

$outputFile = "C:\test\Output.txt"

foreach($folder in $folders){
    $folders2 = gci $folder.FullName
    foreach($smallfolder in $folders2){
        Add-Content $outputFile -Value $smallfolder.Name
    }
}