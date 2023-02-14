targetScope = 'subscription'

@description('The name given to the deployment to be used as an identifier for related deployments')
param deploymentNamePrefix string = '0000000000'

@description('Name of the resource group for the resource')
param resourceNameCommonPart string = 'rg-learn=-freestaticsite1'

@description('Location of the resource group')
param resourceGroupLocation string = 'westus2'

param stage string = 'learn'

var resourceGroupName = 'rg-${resourceNameCommonPart}'

module resourceGroupModule 'resourceGroup.bicep' = {
  name: '${deploymentNamePrefix}_${resourceGroupName}'
  scope: subscription()
  params: {
    name: resourceGroupName
    location: resourceGroupLocation
    stage: stage
  }
}

param appLocation string
param appApiLocation string
param appArtifactLocation string

var staticSiteName = '${resourceNameCommonPart}-sws'

module staticSiteModule 'staticSite.bicep' = {
  name: '${deploymentNamePrefix}_${staticSiteName}'
  dependsOn: [ resourceGroupModule ]
  scope: resourceGroup(resourceGroupName)
  params: {
    stage: stage
    siteName: staticSiteName
    siteLocation: resourceGroupLocation
    appLocation: appLocation
    apiLocation: appApiLocation
    appArtifactLocation: appArtifactLocation
    sku: 'Free'
    skuCode: 'Free'
  }
}

output staticSiteName string = staticSiteModule.outputs.staticSiteName
