// Zuerste Variablen und Parameter definieren
// App Service Plan brauch eindeutigen Namen deswegen verwende ich die ressourcen Gruppen 
// ID, welche später bei der variable für den App Service Plan Namen angehängt wird
param webAppName string = 'v001'
// param webAppName string = uniqueString(resourceGroup().id)
param sku string = 'P1V2' // APP Service Plan SKU (Tier)
param linuxFxVersion string = 'node|14-lts' // Node Applikation
param location string = resourceGroup().location // Location gleich wie bei der Ressourcengruppe
param repositoryUrl string = 'https://github.com/colingit93/clarcd2-webapp' //GitHub URL
param branch string = 'main' //Branch auf dem der Code liegt

// Eindeutiger App Service Plan Name und eindeutiger App Service Name
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower('jochumclarcd-${webAppName}')

// App Service Plan - verwendet die Variablen und Parameter von oben
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

// App Service - verwendet ebenfalls die Var & Params von oben
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

// Deployment / Deployment Center Configuration
resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  name: '${appService.name}/web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}
