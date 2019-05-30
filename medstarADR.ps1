cls
#Script for James for Medstar
<#

Watch Directory
•	AutoRun Directory A (ADR)
•	AutoRun Directory B (Other)

The script would need to read text files in the Watch Directory for “|ADR|” and put those documents into AutoRun Directory A, and everything else in AutoRun Directory B.

I believe there are multiple documents per file, and some may be ADR while others are not. Almost certain they’re BDFs.

Let me know what questions you have before you can get started and I’ll get them cleared up.
-----------------------------------------------------------------------------------------------
I believe a BDF would look like this.

Image Path 1|ADR|1|2|3|4|5|
Attachment 1|
Attachment 2|
Image Path 2|Non ADR|1|2|3|4|5|
Attachment 1|
Attachment 2|
Image Path 3|ADR|1|2|3|4|5|
Attachment 1|
Attachment 2|
Attachment 3|
Attachment 4|


#>

function BDF-WRITE($inputString, $outFile){
    Add-Content -Value $inputString -Path $outFile
}

$watchDirectory = ""
$ADRDirectory = ""
$otherDirectory = ""
$ADRFile = "$ADRDirectory\ADR.BDF"
$otherFile = "$otherDirectory\OTHER.BDF"
$pattern = '^.*(\|ADR\|).*$'
$files = gci -Path $watchDirectory


foreach($file in $files){
    Get-Content $file |
    ForEach-Object{
        if($_ -match $pattern){
            #DO WORK
        }else{
            #DO WORK TO OTHER DIRECTORY
        }
        


    }

}
