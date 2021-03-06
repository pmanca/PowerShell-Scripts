cls

#InputLocation = directory to process TIFs
$InputLocation = "C:\ScerIS Company Files\JCLincoln Health\Test Input\0001" 

#InputBDF = full path to BDF that contains references to images (normally in the above path) and contains the necessary index data (at a minimum, the check number, business unit and check date)
$InputBDF = "C:\ScerIS Company Files\JCLincoln Health\Test Input\0001.bdf"

#InputImagePath = image path found in the BDF (in case it is different than the input location of the actual TIFs). Backslashes must be escaped with a backslash because this variable will be used as part of a regular expression
$InputImagePath = "C:\\JCL Testing\\Exported Files\\JCL Payment Test Folder\\0001\\"

#OutputLocation = directory to output PDFs to (in proper sub-directory structure)
$OutputLocation = "C:\ScerIS Company Files\JCLincoln Health\Test Output"

#NconvertDirectory = directory that contains the ncvonvert.exe file
$NconvertDirectory = "C:\temp\XnView"


$patternCN = "\|([^\|]*)\|([^\|]*)\|"
$patternD = "(\d.*)/\d.*/(\d\d\d\d)"

$Docs = gci "$InputLocation\*0001.tif"

foreach($tiff in $Docs){
    $pattern = $tiff.FullName.Substring($tiff.FullName.length-12,4)
    $patternI = "$pattern.*"
    $PageCount = @(gci "$InputLocation\$pattern*.tif").Count

    $lines = Get-Content($InputBDF)|
    Foreach-object{
        if($_ -match "$patternI.TIF$patternCN$patternD"){
         $BusinessUnit = $matches[2]
         $CheckNumber = $matches[1]
         $Year = $matches[4]
         $Month = $matches[3]   
        }
       
    }
    
    if ($Month -ne $null -and [Int]::Parse($Month) -lt 10) {
        $Month = "0" + $Month
    }

    if((test-path -path "$OutputLocation\$Year") -eq $false){
        New-Item $OutputLocation\$Year -type directory | Out-Null
    }
    
    if((test-path -path "$OutputLocation\$Year\$Month") -eq $false){
            New-Item $OutputLocation\$Year\$Month -type directory | Out-Null             
    }         
    
    $tiff = $tiff.Name.split('.')[0]
    cd "$NconvertDirectory"
   .\nconvert.exe -quiet -out pdf -c 3 -multi -n 1 $PageCount 1 -o "$OutputLocation\$Year\$Month\$BusinessUnit$CheckNumber.pdf" "$InputLocation\$pattern####.tif"

    write-host "$OutputLocation\$Year\$Month\$BusinessUnit$CheckNumber.pdf"
     
}
