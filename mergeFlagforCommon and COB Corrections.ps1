cls

#This programs takes from flagforCOmmonErrorsCOB and COBCorrectionsFRomCOBandRecordNumber
#It adds a appending column to the excel file created in flagfor....if COB has already reviewed it



$file = gci "C:\test\1922BB.bdf"
$file2 = gci "C:\test\1922.bdf"
$lineFileCount = 0
$lineFile2Count = 0
$pattern = "^.*\|\d{4}\|.*\|.*\|(\d{5})\|.*"
$pattern2 = "^(.*)\|(.*)\|(.*)\|(\d*)$"
$logfile = "C:\test\1922test.bdf"
$temp = "Archive Date|1. Volume Year|2. Record Type|3. Deposition Number|4. Record Number|5. DoB|6. Child First Name|7. Child Middle Name|8. Child Last Name|9. Sex|10. Father First Name|11. Father Middle Name|12. Father Last Name|13. Mother First Name|14. Mother Middle Name|15. Mother Maiden Name|16. Physician|17. PoB Street|18. PoB City|19. PoB State|20. PoB Country|21. Residence Of Parents|22. Occupation Of Father|23. Birthplace Of Father|24. Birthplace Of Mother|25. Date Of Record|26. Race|27. Restricted Record|28. Delayed Record|29. Questionable Fields|30. Flag1|Flag2|Flag3|"
function LogWrite{

    param([string]$logstring)
    Add-Content -Value $logstring -path $logfile 

}
LogWrite $temp
Get-Content $file|

ForEach-Object{
    $lineFileCount++
    if($_ -match $pattern){
    [int]$RN = $Matches[1]
    Write-Host $RN
    $temp = $_
    $bool1 = $false
    $bool2 = $false
        Get-Content $file2|
    
        ForEach-Object{
    
        $lineFile2Count++
                if($_ -match $pattern2){
                    [int]$RN2 = $Matches[4]
                    $fixed = $Matches[2]
                    $correct = $Matches[1]
                    $UDI = $Matches[3]
                    if($RN -eq $RN2){
                       if($bool2 -eq $false){
                            if($fixed -eq "`""){}else{
                                $temp = $temp + "COB Reviewed($fixed,$correct,$UDI)"
                                Write-Host $temp

                                LogWrite $temp 
                                $bool1 = $true
                                $bool2 = $true
                                }
                       }
                    }
                    
            
                }else{
                    LogWrite $temp
                
                }
            

    
        }

        if($bool1 -eq $false){

        LogWrite $_
        }

    }



}
