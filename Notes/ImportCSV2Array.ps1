$file = "L:\Pioneer\ConcurTemp Files\p000118235gf_20150909005645.CSV"
$file2 = "C:\test\test.bdf"
$arr = Import-Csv -Path $file -Header "RecordID","B","C"



write-host $arr[1].RecordID


