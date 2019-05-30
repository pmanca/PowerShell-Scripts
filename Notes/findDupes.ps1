$files = gci "\\hyperion\CoB" -Recurse|Export-Csv  "C:\test\test.csv"



#RUn this program to grab every file in a directory.  then open in excel and highligt duplicate file names.  