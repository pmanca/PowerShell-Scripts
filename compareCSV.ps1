cls
$logfile = "C:\test\1931diff3.txt"
function LogWrite{

    param([string]$logstring)

    Add-Content -value $logstring -Path $logfile
    
}

$file = "C:\test\compare xls\1931_CoB_Birth_Records.csv"
$file2 = "C:\test\compare xls\1931_CoB_Birth_Records ERRORS.csv"

$linecount = 0
LogWrite "Record Number - Field - Changed to"
LogWrite `n
Get-Content $file|

ForEach-Object{
    $linecount++
    $line2Count = 0
    
    
    $a1 = $_.Split(",")[0]
    $b1 = $_.Split(",")[1]
    $c1 = $_.Split(",")[2]
    $d1 = $_.Split(",")[3]
    $e1 = $_.Split(",")[4]
    $f1 = $_.Split(",")[5]
    $g1 = $_.Split(",")[6]
    $h1 = $_.Split(",")[7]
    $i1 = $_.Split(",")[8]
    $j1 = $_.Split(",")[9]
    $k1 = $_.Split(",")[10]
    $l1 = $_.Split(",")[11]
    $m1 = $_.Split(",")[12]
    $n1 = $_.Split(",")[13]
    $o1 = $_.Split(",")[14]
    $p1 = $_.Split(",")[15]
    $q1 = $_.Split(",")[16]
    $r1 = $_.Split(",")[17]
    $s1 = $_.Split(",")[18]
    $t1 = $_.Split(",")[19]
    $u1 = $_.Split(",")[20]
    $v1 = $_.Split(",")[21]
    $w1 = $_.Split(",")[22]
    $x1 = $_.Split(",")[23]
    $y1 = $_.Split(",")[24]
    $z1 = $_.Split(",")[25]
    $aa1 = $_.Split(",")[26]
    $ab1 = $_.Split(",")[27]
    $ac1 = $_.Split(",")[28]
    $ad1 = $_.Split(",")[29]
    $ae1 = $_.Split(",")[30]
    $af1 = $_.split(",")[31]
    
        Get-Content $file2|

            ForEach-Object{
            $line2count++
            $errorCountLine = 0
            
                if($line2count -eq $linecount){
                        $a2 = $_.Split(",")[0]
                        $b2 = $_.Split(",")[1]
                        $c2 = $_.Split(",")[2]
                        $d2 = $_.Split(",")[3]
                        $e2 = $_.Split(",")[4]
                        $f2 = $_.Split(",")[5]
                        $g2 = $_.Split(",")[6]
                        $h2 = $_.Split(",")[7]
                        $i2 = $_.Split(",")[8]
                        $j2 = $_.Split(",")[9]
                        $k2 = $_.Split(",")[10]
                        $l2 = $_.Split(",")[11]
                        $m2 = $_.Split(",")[12]
                        $n2 = $_.Split(",")[13]
                        $o2 = $_.Split(",")[14]
                        $p2 = $_.Split(",")[15]
                        $q2 = $_.Split(",")[16]
                        $r2 = $_.Split(",")[17]
                        $s2 = $_.Split(",")[18]
                        $t2 = $_.Split(",")[19]
                        $u2 = $_.Split(",")[20]
                        $v2 = $_.Split(",")[21]
                        $w2 = $_.Split(",")[22]
                        $x2 = $_.Split(",")[23]
                        $y2 = $_.Split(",")[24]
                        $z2 = $_.Split(",")[25]
                        $aa2 = $_.Split(",")[26]
                        $ab2 = $_.Split(",")[27]
                        $ac2 = $_.Split(",")[28]
                        $ad2 = $_.Split(",")[29]
                        $ae2 = $_.Split(",")[30]
                        $af2 = $_.split(",")[31]

                if($a2 -ne ""){
                    $errorCountLine += (@(Compare-Object $b1 $b2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                            LogWrite "$f2 - Archive Date - $b2"
                            $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $c1 $c2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                         LogWrite "$f2 - VolumeYear - $c2"
                         $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $d1 $d2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Record Type - $d2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $e1 $e2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Deposistion - $e2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $f1 $f2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Record Number - $f2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $g1 $g2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Child First Name - $g2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $h1 $h2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Child Middle Name - $h2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $i1 $i2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Child Last Name - $i2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $j1 $j2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Race - $j2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $k1 $k2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Sex - $k2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $l1 $l2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Father First Name - $l2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $m1 $m2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Father Middle Name - $m2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $n1 $n2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Father Last Name - $n2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $o1 $o2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Mother First Name - $o2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $p1 $p2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Mother First Name - $p2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $q1 $q2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Mother Middle Name - $q2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $r1 $r2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Mother Maiden Name - $r2"
                        $errorCountLine = 0
                    }                   
                   $errorCountLine += (@(Compare-Object $s1 $s2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Physician - $s2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $t1 $t2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - PoB Street - $t2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $u1 $u2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - PoB City - $u2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $v1 $v2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - POB State - $v2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $w1 $w2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - POB Country - $w2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $x1 $x2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Residence - $x2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $y1 $y2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Occupation of Father - $y2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $z1 $z2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Birthplace of Father - $z2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $aa1 $aa2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Birthplace of Mother - $aa2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $ab1 $ab2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Date of Record - $ab2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $ac1 $ac2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Restricted" - $ac2;
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $ad1 $ad2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Delayed Record - $ad2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $ae1 $ae2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Questionable Fields - $ae2"
                        $errorCountLine = 0
                    }
                    $errorCountLine += (@(Compare-Object $af1 $af2 -SyncWindow 0).count / 2)
                   if($errorCountLine -ne 0){
                        LogWrite "$f2 - Flag1 - $af2"
                        $errorCountLine = 0
                    }
                  } 
                }
            
            
            
            
            }


	}