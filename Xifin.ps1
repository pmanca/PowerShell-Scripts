$folders = gci "C:\Test\XIFIN\" | where {$_.Attributes -eq 'Directory'}

foreach($folder in $folders){
    $ranNum = Get-Random
    $newName = $folder.BaseName + $ranNum
    Rename-Item -Path $folder.FullName -NewName $newName 
}
$classpath = "C:/Test/EgeneraCalculator.jar"
$env = "-Dcontext=atest1 -Dresourcepath=."
. java.exe -jar $classpath $env 