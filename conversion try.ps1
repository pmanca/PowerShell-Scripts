cls
$file = gci -path "C:\Program Files (x86)\ScerIS\WinApp\idp.xml"

$pattern ="(.*).(xml)"
 
if($file -match $pattern){
    $matches[2] = "lic"
    
    
}
$file = $matches[1] + "." + $matches[2]

$file
