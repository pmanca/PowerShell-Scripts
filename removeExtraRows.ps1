cls

$path = Read-Host "Enter in the path for the files to be processed"
$path2 = Read-Host "Enter the path you would like the processed files to go to"

            if(Test-Path $path2){
                echo("Folder Already Exists")
            }
            else
            {
                New-Item -ItemType Directory -path $path2 -Force
                echo("Folder created")
            }


$files = gci -path $path -filter "*.txt"

    


foreach($file in $files){

  $lineCount = 0
   
    
    Get-Content $file.FullName |

    ForEach-Object{
    
    if($lineCount -lt 40){

    $_
    $lineCount++
    

    }
    else{
    }
    
 

    }|Set-Content "$path2\$file"

}#end of foreach
