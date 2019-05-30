#This script was edited by Peter Manca on 6/2/2015.  SMD was added as a third option.  I moved the nomatch to patter4 and set pattern3 from no match to match CORRSMD
#This script is called by a task in task scheduler called Correspindence Sorting

#set file paths and regex patterns
$InputPath = "O:\ocrff\data\miscletters\"
$DateStr = get-date -format "MM-dd-yyyy-hh-mm-ss"
$OutputPath1 = "O:\ocrff\data\miscletters\PUBS\PUBS_" + $DateStr + ".txt"
$OutputPath2 = "O:\ocrff\data\miscletters\NORTH\NORTH_" + $DateStr + ".txt"
$OutputPath3 = "O:\ocrff\data\miscletters\SMD\SMD_" + $DateStr + ".txt"
$OutputPath4 = "O:\ocrff\data\miscletters\NOMATCH\NOMATCH_" + $DateStr + ".txt"
$Pattern1 = "CORRPUBS"
$Pattern2 = "CORRNORTH"
$Pattern3 = "CORRSMD"
$Pattern4 = "\|\|"


#set to delete or move source files (yes for delete, no for move) and set move to location
$DeleteAfterProcessing = "No"
$MoveTo = "O:\ocrff\data\miscletters\Processed\"

#get files
$Files = gci "$InputPath\*.tx*"

#loop files
Foreach ($File in $Files){
    $FileName = $File.Name
    $FullPath = $InputPath + $FileName
    $FileContent = get-content $FullPath

    #parse lines
    foreach ($line in $FileContent){
        If ($line -match $Pattern1){
            $line | Out-File -FilePath $OutputPath1 -append
            $LastLine = "PUBS"
        } ElseIf ($line -match $Pattern2){
            $line | Out-File -FilePath $OutputPath2 -append
            $LastLine = "NORTH"
        } ElseIf ($line -match $Pattern3){
            $line | Out-File -FilePath $OutputPath3 -append
            $LastLine = "SMD"
        } ELseIf($line -match $Pattern4){
            $line | Out-File -FilePath $OutputPath4 -append
            $LastLine = "NA"
        } Else {
            If ($LastLine -eq "PUBS"){
                $line | Out-File -FilePath $OutputPath1 -append
            } ElseIF ($LastLine -eq "NORTH"){
                $line | Out-File -FilePath $OutputPath2 -append
            } ElseIF ($LastLine -eq "SMD"){
                $line | Out-File -FilePath $OutputPath3 -append
            } ElseIF ($LastLine -eq "NA"){
                $line | Out-File -FilePath $OutputPath4 -append
            }
        }
    }

    #delete or move source files
    If ($DeleteAfterProcessing -eq "Yes"){
        Remove-Item $FullPath
    } Else {
        Move-Item $FullPath $MoveTo
    }
 }