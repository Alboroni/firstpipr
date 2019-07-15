$rgName = "testtag"
$storageAccountARMTemplate = "StorageAccount\deploy.json"
$uncompliantStorageAccountARMTemplateParameters = "Parameters\lab02-HTTP.storage.json"
$compliantStorageAccountARMTemplateParameters = "Parameters\lab02-HTTPS.storage.json"

# Deploy Uncompliant Storage Account (HTTP traffic allowed)
$httpStorageAccountAzDeploymentParams = @{
    ResourceGroupName     = $rgName
    TemplateFile          = $storageAccountARMTemplate
    TemplateParameterFile = (Get-Item $uncompliantStorageAccountARMTemplateParameters).FullName
    Name                  = "storageAccount-" + (Get-Date -Format FileDateTimeUniversal)
    ErrorAction           = "SilentlyContinue"
    ErrorVariable         = "saDeploymentError"
}
Write-Output "Deploying HTTP Storage Account"
New-AzResourceGroupDeployment @httpStorageAccountAzDeploymentParams | Out-Null
if ($saDeploymentError) {
    Write-Output "Error during Storage Account deployment"
    $saDeploymentError.Exception
}

# Deploy Compliant Storage Account (HTTP traffic disallowed)
$httpsStorageAccounttAzDeploymentParams = @{
    ResourceGroupName     = $rgName
    TemplateFile          = (Get-Item $storageAccountARMTemplate).FullName
    TemplateParameterFile = (Get-Item $compliantStorageAccountARMTemplateParameters).FullName
    Name                  = "storageAccount-" + (Get-Date -Format FileDateTimeUniversal)
}
Write-Output "Deploying HTTPS Storage Account"
New-AzResourceGroupDeployment @httpsStorageAccounttAzDeploymentParams | Out-Null