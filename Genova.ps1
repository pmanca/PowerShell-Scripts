<#This Script was written by Peter Manca on 2/19/2016
it was written for Genova to format the output from anydoc.
It will take all of the information on each level and place it on the same line with
the first image of each document.  


Rough ex.

image1.tif|#|$|%|DE||D|D|C|D|D|D|
image2.tif|ED|D|R|D|$|D|F|G|H|F|F|


WIll BECOME


image1.tif|#|$|%|DE||D|D|C|D|D|D||ED|D|R|D|$|D|F|G|H|F|F|
image2.tif|


images can come in out of order but will be contigous to their docID

#>


cls

#Function to write out to output files
function Output-write([string]$logString, $logfile){
    Add-Content -Path $logfile -Value $logString
}
#Grabs all the files
$files = gci "C:\Test\" -Filter "*.txt"
#to cylce through all of the files
foreach($file in $files){
    $name = $file.FullName #name of the file including 
    $count = 0
    $values = New-Object system.Array[][] 1000,1000
    $values.Initialize();

       
    Get-Content -Path $name | foreach-object{
        
        
        $tempString = $_  #assigns current element in pipe to tempstring element = line on file
        
        #creates an array called Matches to hold each element within an element. 
        #Each line comes in as A|B|C|D|E|F| so array would hold @(A,B,C,D,E,F)
        $Matches = $tempString.Split('|')


        
        #count how many elements are on each line will be different for each line
        $delimSectionTotalCount = $Matches.Count

        #add to jagged array
        for($i = 0; $i -lt $delimSectionTotalCount; $i++){
            $values[$count][$i] = $Matches[$i]
        }
            
        #keep total count to use later
        $count++

    }#End of foreach-object loop

    #################################################################################
    <#
    #Everything is in a jagged 2-dimensional array now
    #
    #time to move into a new array with the right format
    #
    #>


     #Base name of the current file
     $baseName = $file.BaseName
     #output file
     $outfile = "C:\test\$baseName.out"
     #instantiating oldDocID as none
     $oldDocID = "none"
     #Instantiating $strings array which will be used as an ordered array opposed to the original input
     #This array will only hold one document(multiple images within 1 document) at a time
     $strings = New-Object system.Array[][] 1000,1000
     $strings.Initialize()
     #For loop to do order and print out lines
     for($i = 0; $i -lt $count; $i++){
        #sets the docID variable
        [string]$DocID = $values[$i][1].get(0)
        #sets the PageNumber variable of the current image
        [int]$pageNum = $values[$i][2].get(0)
        
        
        if($DocID -eq $oldDocID -or $i -eq 0 ){#if the first image or any image that is in the current document
            for($j=0;$j -lt $values[$i].Count; $j++){#to place arrays in order
                $strings[$pageNum][$j] = $values[$i][$j]
                write-host $strings[$pageNum][$j]
            }
        }else{
            #means you have to do work on the ordered array now.  
            #If you are here it means that you have hit a new document and must process the old one


            #setting global arrays
            #imagenameArray will hold all of the image names in a document outside of the first image
          $Global:imageNameArray = New-Object System.Collections.ArrayList
          #variable to hold line 1 or image one details in a document
          $Global:line1 = ""
          #This for loop is to cycle through the array of Strings J will be the first dimension or for each image
          for($j = 1;$j -lt 100;$j++){
            
            $tempString = ""
            #This for loop is to cyle through each element of each image or the second dimension of the strings array
            for($k = 0;$k -lt 100; $k++){
                #if the first time through
                if($j -eq 1){
                    #the second and third column must be removed int he final out put.  
                    #second is docID and third is page number
                    if($k -ne 1 -and $k -ne 2){
                        #Fills the temporary string with information
                        $tempString += $strings[$j][$k]
                        $tempString += '|'
                        write-host "K:"$k " TempString = " $tempString 
                    }
                }else{
                    #if it is not the first time through then it is not the first page as the strings array is ordered
                    #now the first coulumn must not be included as well as the second and the third
                    #first column is the image name and path which will be added to the imageNameArray below
                    if($k -ne 0 -and $k -ne 1 -and $k -ne 2){
                        $tempString += $strings[$j][$k]
                        $tempString += '|'
                        write-host "K:"$k " TempString = " $tempString 
                    }elseif($k -eq 0){
                        #add to imageNameArray to printout later
                        $imageNameArray.Add($strings[$j][$k].Get(0))
                    }
                }
            }
            #The next two lines will clean up all the extra pipes
            $tempString = $tempString -replace "\|\|"
            $tempString += '|'
            #provides a more permanent home for the temp string
            $line1 += $tempString
          }
          #cleans up the unneeded pipes
          $line1 = $line1 -replace "\|\|","|"
          
          #This next block of code will write to the output file
          #line1 will be written first and then the image names will be
          #afterwards one line at a time
          Write-Host $line1
          Output-write -logfile $outfile -logString $line1
          for($j=0;$j -lt $imageNameArray.Count; $j++){

            Write-Host $imageNameArray.Item($j)
            $imageTempName = $imageNameArray.Item($j) + '|'
            Output-write -logfile $outfile -logString $imageTempName
          }
         
            #clear the strings at the end also run the for loop in the if statement as well for the first array for the next docID
            
            $strings = New-Object system.Array[][] 1000,1000
            $strings.Initialize()



            #First page received from next group for next set
            
            for($j=0;$j -lt $values[$i].Count; $j++){#to place arrays in order
               $strings[$pageNum][$j] = $values[$i][$j]
               write-host $strings[$pageNum][$j]           
            }
            

        }#end of else block
        
        
        #sets long time DocID variable from the docID local to this iteration of loop.
        #This is used to make sure images belong to the same document
        $oldDocID = $DocID
        
        
     }#end of for loop to work on jagged array


          #end of document -> do same as above for final document group of file
          #notes for each line are above
          $Global:imageNameArray = New-Object System.Collections.ArrayList
          $Global:line1 = ""
          for($j = 1;$j -lt 10;$j++){#change 8 to 100 whenb done
            
            $tempString = ""
            for($k = 0;$k -lt 100; $k++){
                if($j -eq 1){
                    if($k -ne 1 -and $k -ne 2){
                        $tempString += $strings[$j][$k]
                        $tempString += '|'
                        write-host "K:"$k " TempString = " $tempString 
                    }
                }else{
                    if($k -ne 0 -and $k -ne 1 -and $k -ne 2){
                        $tempString += $strings[$j][$k]
                        $tempString += '|'
                        write-host "K:"$k " TempString = " $tempString 
                    }elseif($k -eq 0){
                        #add to imageNameArray to printout later
                        $imageNameArray.Add($strings[$j][$k].Get(0))
                    }
                }
            }
            $tempString = $tempString -replace "\|\|"
            $tempString += '|'
            $line1 += $tempString
          }
          $line1 = $line1 -replace "\|\|","|"
          
          Write-Host $line1
          Output-write -logfile $outfile -logString $line1
          for($j=0;$j -lt $imageNameArray.Count; $j++){

            Write-Host $imageNameArray.Item($j)
            $imageTempName = $imageNameArray.Item($j) + '|'
            Output-write -logfile $outfile -logString $imageTempName
          }



}#end of foreach loop
