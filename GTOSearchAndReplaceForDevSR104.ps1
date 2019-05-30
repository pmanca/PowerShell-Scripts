cls
#Script for Erick for processing gtos.  the only think that needs to change out side of paths is the form id of the eform so the 
#eform has to be loaded first to the number is known.  
$files = gci "C:\Work for Erik GTO examples\Form1 - Copy" -Filter "*.gto"
$patternFormID = "(EFormID-TZ\(-1\)L\(1\)C\(U\)-41-1-77,51,2372,1676)(:.*)"
$patternAssignedToUser = "(AssignedToUserID-TZ\(-1\)L\(1\)C\(U\)-40-1-77,51,2372,1676:)(.*)"
$outputFile = "C:\work for erik gto examples\Form1 - Copy\output.txt"
$formID = 6
$fileCount = 0
$loadUser1 = "CD222385-7636-4CDC-8A04-BDECE8711226"
$loadUser2 = "399E3C2C-062F-4672-AE1D-F025627E8DAD"
$loadUser3 = "EC87CB91-56DB-403F-B592-7D4D131F0BD5" 
$loadUser4 = "AA80075C-06BC-4DA5-B0CB-46B93AE0D0D3"
$loadUser5 = "7172B22C-887A-4539-82A6-B6CED7C1F04F"
$loadUser6 = "6B2D9D32-D909-4AA7-AFD0-C784C69434FA"
$loadUser7 = "F932FD23-7146-413D-815A-336C4F385310"
$loadUser8 = "94630F4E-7F81-425B-B6EA-5558837372BC"
$loadUser9 = "AD82A115-7D30-4572-B004-A4B0B0F5E077"
$loadUser10 = "9521BDD1-9104-4561-80A0-90235712AE68"
$loadUser11 = "AB67B0A0-8334-444B-BB0D-CDA59B82D82F"
$loadUser12 = "59082FB7-E8B7-47A0-96E4-85FE9FB51E63"
$loadUser13 = "8907F2BC-2552-4561-BD12-4E5CC38C1CFA"
$loadUser14 = "618710F3-5385-4C77-A7A6-9F295908E927"
$loadUser15 = "F727E3A1-FA45-4C80-8923-8B25FEEE3E59"
$loadUser16 = "4D8D9FD0-3998-4E59-98DD-66659C26164E"
$loadUser17 = "B283BBE7-D9B1-4E28-AD20-11756BC55F9D"
$loadUser18 = "112DA72A-DA92-47F5-B205-F474F42A3617"
$loadUser19 = "F5C1D5AB-AC19-4813-98A3-4BFFFCD44373"
$loadUser20 = "2B2059B6-20CD-48BD-834D-7F43DD3EC170"
$loadUser21 = "940DDF5C-6E94-43C9-A6BF-AD021874D6D6"
$loadUser22 = "DA55BFFE-3972-4920-964D-CFFC4B609B24"
$loadUser23 = "3B94C8D6-07E4-4945-AD5B-2816E6D66D0E"
$loadUser24 = "123E6A89-2A5D-4377-84F3-8B04C857018A"
$loadUser25 = "B85806AD-C878-4561-92B2-A5AB58717BC0"
$loadUser26 = "A037E078-70C9-4906-90C7-3DD928F5613C"
$loadUser27 = "8847A011-D711-4353-A932-9291981F502A"
$loadUser28 = "2A6C538B-888B-4245-AA31-DF505621394E"
$loadUser29 = "9022E142-DD61-4B74-83AB-83998218976D"
$loadUser30 = "E2B716FD-2674-478C-8D84-24ABDECDB281"
$loadUser31 = "28972405-422B-45E0-AA76-2B8EB17AEBF0"
$loadUser32 = "2CF16E7B-7C3B-4C2B-A7D6-265EDE652E94"
$loadUser33 = "04A79F2D-B747-4DF5-A5FA-8A4990F7E282"
$loadUser34 = "5DB6015F-B875-44FB-AA7A-C53ACAE59B38"
$loadUser35 = "F4150787-8D30-4FDF-9113-C63014D7E4C1"
$loadUser36 = "D9E0D4F6-1AA2-47CD-9F83-2C2387B9E086"
$loadUser37 = "74CE9B8C-B526-4F3E-88A6-718AF4981195"
$loadUser38 = "C67BF221-7D49-4304-B540-4EA60D1CA8FB"
$loadUser39 = "7E990407-8A12-4CA4-BAEE-4755DA2B2908"
$loadUser40 = "C5D7D7AD-7035-464F-B391-CC28F34ED17F"
$loadUser41 = "2758762F-1B39-44A0-BF34-4755B816AAC7"
$loadUser42 = "54F83FD0-1EBB-4DAA-A82B-A60EB81E54BB"
$loadUser43 = "3AD357A0-7627-40A2-9FA1-F7C08FC0340B"
$loadUser44 = "E8307FFE-B077-4682-A34F-9ACCA59AA68A"
$loadUser45 = "25FEC6C4-6510-4C01-8BDF-1F6DC4DB604E"
$loadUser46 = "493870B2-4584-4DFE-87B9-25471AA749CF"
$loadUser47 = "E116A55D-F29C-4A9A-B5E4-3A20AA94F5B1"
$loadUser48 = "8A1D3042-16CC-470D-BC17-0F03DDBC769B"
$loadUser49 = "16845F36-9AB8-4151-AF81-0C9469F4725C"
$loadUser50 = "1B933620-A85A-4187-BB4F-93DDF3ED6466"
$loadUser51 = "70A3DA9F-B11E-44F9-BC6A-31F20A3B3B0A"

[String[]]$global:loadUserArray = @($loadUser1,$loadUser2,$loadUser3, $loadUser4, $loadUser5, $loadUser6, $loadUser7, $loadUser8, $loadUser9, $loadUser10, $loadUser11, $loadUser12, $loadUser13, $loadUSer14
                                    $loadUser15, $loadUser16, $loadUser17, $loadUser18, $loadUser19, $LoadUser20, $loadUser21, $loadUser22, $loadUser23, $loadUser24, $loadUser25, $loadUser26, $loadUser27
                                    $loadUser28, $loadUser29, $loadUser30, $loadUser31, $loadUser32, $loadUser33, $loadUser34,$loadUser35, $loadUser36, $loadUSer37, $loadUser38, $loadUser39, $loadUser40
                                    $loadUser41, $loadUser42, $loadUser43, $loadUser44, $loadUser45, $loadUser46, $loadUser47, $loadUser48, $loadUser49, $loadUser50, $loadUser51)
Write-Host $loadUserArray[0]

foreach($file in $files){
    Write-Host $file.FullName

    Get-Content -Path $file.FullName|

        ForEach-Object{
        
        $found = $false
            if($_ -match $patternAssignedToUser){
                $value = $loadUserArray[$fileCount]
                $global:temp = $_ -replace $Matches[2] , $value
               # Write-Host $temp
                Add-Content -path $outputFile -Value $temp
                $found = $true
            }
            if($_ -match $patternFormID){
               # Write-Host "Match 2" + $Matches[2]
                $temp = $_ -replace $Matches[2], ":$formID"
                Add-Content -path $outputFile -Value $temp
                
            }elseif($found -eq $false){
                $temp = $_
                Add-Content -path $outputFile -Value $temp
            }
        
        
           
           
        
        }

        $holdFileName = $file.Name
        Remove-Item -Path $file.FullName
        Rename-Item -path $outputFile -NewName $holdFileName
        if($fileCount -lt 50){
            $fileCount++
        }else{
            $fileCount = 0
        }

}