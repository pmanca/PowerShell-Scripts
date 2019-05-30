#takes in a single column text file and outputs it as a 3 column csv file
#each line in the txt file is a last name where some of them have suffixes attached to them




function Split-NameString
{
    PARAM (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Name
    )
    PROCESS 
    {
        $trimmedName = $Name.Trim()
        $trimmedName -match "^(?<surname>.*?)(?:| (?<suffix>[^ ]{1,3}))$" | Out-Null
        Write-Output (New-Object -TypeName PSCustomObject -Property @{
            FullName = $trimmedName;
            Surname = $Matches["surname"];
            Suffix = $Matches["suffix"];
        })
    }
}


$names = Get-Content "C:\test\suffix test\Copy of COB_ChildLastNames (3).txt"
$names | Split-NameString | Select FullName, Surname, Suffix | Export-Csv -NoTypeInformation -Path "C:\test\suffix test\Output.csv"