


 Get-ChildItem -Path "\\lynx2\Customers" -Recurse | where-object {($_.PsIsContainer)} | get-acl | Out-File "C:\test\test123.txt"#format-list