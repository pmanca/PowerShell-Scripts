cls
#Peter Manca 08/04/2015
#Ungreedy testing for regex. 
#this solution is to grab Alders on the first string and grab the second or second and
#third name in the second string.  
#Another way for this to be done is to use the nonwhitespace character
#^(\S)\s(.*)$
$string = "ALDERS PAUL GERARD"
$string2 = "Alders Paul"

$pattern = '^(.*?)\s(.*)$'



if($string -match $pattern){
    $last = $Matches[1]
    Write-Host "Success - $last"
}

if($string2 -match $pattern){
    $last = $Matches[1]
    Write-Host "Success - $last"
}