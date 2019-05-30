$files = gci "P:\Groups\Implementation\Customers\D&H Distributing\04 - Active Projects\03262015 - AX Migration Project\DBL files"

$i = 0

foreach($file in $files){
    Add-Content -Value $file.BaseName -Path "C:\test\DBLNames.txt"
    $i++
    

}
$i = $i-3 # three account for the three test DBLS
Write-Host $i
