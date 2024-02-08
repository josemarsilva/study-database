## ############################################################################
## filename: script-deploy-tgt-08-01.ps1
## purpose : Copy source script generated with create logins and sp_addrolemember
## revision: 2024-02-08 15:45 - josemarsilva - 
## remarks : 
##          * Parameters[]:
## ############################################################################

# Get (.tsv) files to import: source and target
$a_fromTsvFiles_toSqlFiles = @(
    [tuple]::Create("script-deploy-src-02-01_{deploy_database}.tsv", ".\script-deploy-tgt-08-02.sql"),
    [tuple]::Create("script-deploy-src-02-02_{deploy_database}.tsv", ".\script-deploy-tgt-08-03.sql")
)

# Loop files to import
foreach ($fromTsvFile_toSqlFile in $a_fromTsvFiles_toSqlFiles) {

    # Iteration
    Write-Output "Extracting (CREATE LOGIN / sp_addrolemember) from '$($fromTsvFile_toSqlFile.Item1)' to '$($fromTsvFile_toSqlFile.Item2)' ..."

    # Copy from (.tsv) to (.sql)
    Copy-Item $fromTsvFile_toSqlFile.Item1 -Destination $fromTsvFile_toSqlFile.Item2

    # Remove first line and Replace <TAB> by " "
    $oldContent = (Get-Content -Path $fromTsvFile_toSqlFile.Item2) -replace "`t", " "
    $newContent = $oldContent[1..($oldContent.Length - 1)]

    # Write new Content to file
    $newContent | Set-Content -Path $fromTsvFile_toSqlFile.Item2

    # Add "GO" to bottom file
    Add-Content -Path $fromTsvFile_toSqlFile.Item2 ""
    Add-Content -Path $fromTsvFile_toSqlFile.Item2 "GO"
    Add-Content -Path $fromTsvFile_toSqlFile.Item2 ""


}
