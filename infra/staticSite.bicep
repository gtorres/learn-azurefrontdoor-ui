@description('learn, poc, dev, test, etc')
param stage string

param siteName string
param siteLocation string

@description('The tier of the SKU')
param sku string
@description('The name of the SKU')
param skuCode string

param appLocation string
param apiLocation string
param appArtifactLocation string

resource staticSite 'Microsoft.Web/staticSites@2021-01-15' = {
  name: siteName
  location: siteLocation
  tags: {
    environment: stage != null ? stage : ''
  }
  properties: {
    buildProperties: {
      appLocation: appLocation
      apiLocation: apiLocation
      appArtifactLocation: appArtifactLocation
    }
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
  }
  sku: {
    tier: sku
    name: skuCode
  }
}

param appSettings object = {}

resource staticSiteAppSettings 'Microsoft.Web/staticSites/config@2021-01-15' = {
  parent: staticSite
  name: 'appsettings'
  properties: appSettings
}

output staticSiteName string = staticSite.name
