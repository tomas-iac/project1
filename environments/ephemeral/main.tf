module "main" {
  source                  = "../../terraform/"
  environment             = "ephemeral"
  namePrefix              = "project1"
  location                = "westeurope"
  vnetName                = azurerm_virtual_network.test.name
  vnetResourceGroup       = azurerm_resource_group.test.name
  subnetPrefixAks         = "10.0.0.0/22"
  subnetPrefixServices    = "10.0.4.0/24"
  privateDnsZoneIdAks     = azurerm_private_dns_zone.sql.id
  privateDnsZoneIdSql     = azurerm_private_dns_zone.aks.id
  logAnalyticsWorkspaceId = azurerm_log_analytics_workspace.test.id
  depends_on = [
    azurerm_virtual_network.test,
  ]
}
