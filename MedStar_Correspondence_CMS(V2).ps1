#This script was edited by Peter Manca on 6/2/2015.  SMD was added as a third option.  I moved the nomatch to patter4 and set pattern3 from no match to match CORRSMD
#This script is called by a task in task scheduler called Correspindence Sorting

#This script was updated on 2/9/2015.  The options were removed and replaced with just an option for CMS and ADR to make
#it simpler.
#Peter Manca

#set file paths and regex patterns
$InputPath = "Z:\ocrff\data\CMS\"
$DateStr = get-date -format "MM-dd-yyyy-hh-mm-ss"
$OutputPath1 = "Z:\ocrff\data\CMS\CMS\CMS_" + $DateStr + ".txt"
$OutputPath2 = "Z:\ocrff\data\CMS\ADR\ADR_" + $DateStr + ".txt"
$OutputPath3 = "Z:\ocrff\data\CMS\NOMATCH\NOMATCH_" + $DateStr + ".txt"
$Pattern1 = "^.*\|CMS\|$"
$Pattern2 = "^.*\|ADR\|$"
$Pattern3 = "\|\|"

#set to delete or move source files (yes for delete, no for move) and set move to location
$DeleteAfterProcessing = "No"
$MoveTo = "O:\ocrff\data\CMS\Processed\"

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
            $LastLine = "CMS"
        } ElseIf ($line -match $Pattern2){
            $line | Out-File -FilePath $OutputPath2 -append
            $LastLine = "ADR"
        }  ElseIf ($line -match $Pattern3){
            $line | Out-File -FilePath $OutputPath3 -append
            $LastLine = "NA"
        } Else {
            If ($LastLine -eq "CMS"){
                $line | Out-File -FilePath $OutputPath1 -append
            } ElseIF ($LastLine -eq "ADR"){
                $line | Out-File -FilePath $OutputPath2 -append
            }ElseIF ($LastLine -eq "NA"){
                $line | Out-File -FilePath $OutputPath3 -append
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