## ############################################################################
## filename: script-deploy-tgt-10-01.ps1
## purpose : Script import Tab-Separated-Values (.tsv) file from Source and Target
## revision: 2024-02-06 16:45 - josemarsilva - 
## remarks : 
##          * Parameters[]:
## ############################################################################

# Get (.tsv) files to import: source and target
$a_tsvFiles = @(
    [tuple]::Create("script-deploy-tgt-09-04_{deploy_database}.tsv")
)

# Loop files to import
foreach ($tsvFile in $a_tsvFiles) {

    # Iteration
    Write-Output "Serching for any problem in file '$($tsvFile.Item1)' ..."

    # Search ERROR 
    Get-Content $tsvFile.Item1 | Where-Object { $_ -match " ERROR" }  | Out-File -FilePath .\script-deploy-tgt-10-01_{deploy_database}.tsv
    
}
