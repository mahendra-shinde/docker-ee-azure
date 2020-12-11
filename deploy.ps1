param (
    $GroupName = 'Sample-RG',
    $Location = 'Southeast Asia' 
)
Write-Host "Creating or Updating the resource group $GroupName"
# Deploying Resource group
New-AzResourceGroup -Name $GroupName -Location $Location -Force

Write-Host "Deploying template"
# Deploying Template
New-AzResourceGroupDeployment -Name deploy1 -ResourceGroupName $GroupName -TemplateFile .\azuredeploy.json -TemplateParameterFile .\azuredeploy.parameters.json 

