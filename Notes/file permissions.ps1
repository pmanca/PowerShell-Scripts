Get-ChildItem -Recurse "\\lynx2\C$\ScerISData\Customer Data" | where {$_.Attributes -eq 'Directory'} | Get-Acl | Export-Csv "C:\test\dir-temp.csv"

Get-ChildItem -Recurse "\\lynx2\C$\Customers" | where {$_.Attributes -eq 'Directory'} | Get-Acl | Export-Csv "C:\test\dir-temp2.csv"