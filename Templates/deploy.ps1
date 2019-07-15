# Deploy a Policy Definition via ARM Template
$pathToARMTemplate = "storageaccount\policy-denyHttp.json"

$policyDefinitionAzDeploymentParams = @{
    TemplateFile = (Get-Item $pathToARMTemplate).FullName
    Name         = "policyDeployment-" + (Get-Date -Format FileDateTimeUniversal)
    Location     = "westeurope"
}
New-AzDeployment @policyDefinitionAzDeploymentParams