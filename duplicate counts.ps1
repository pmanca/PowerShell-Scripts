cls
get-content C:\test\images.txt | sort -u > C:\test\FileWithoutDupes.txt
$original = Get-Content C:\test\images.txt
$Original.Length
$new = Get-Content C:\test\FileWithoutDupes.txt
$new.Length