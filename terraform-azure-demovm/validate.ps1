$modulefolders = @("$PSScriptRoot/modules","$PSScriptRoot/examples","$PSScriptRoot/test/fixtures")

$configfolders = @($PSScriptRoot)
foreach ($modulefolder in $modulefolders) {
    Write-Host $modulefolder
    if (Test-Path $modulefolder)
    {
        Set-Location $modulefolder
        $configfolders += Get-ChildItem -Directory -recurse
    }
    else {
        continue
    }
}
foreach ($configfolder in $configfolders)
{
    Write-Host "inside config folder" $configfolder
    Set-Location $configfolder
    terraform init -backend=false
    if ($LASTEXITCODE -ne 0)
    {
        Throw "Error initializing $configfolder"
    }
    terraform validate
    if ($LASTEXITCODE -ne 0)
    {
        Throw "Error validating $configfolder"
    }
}
