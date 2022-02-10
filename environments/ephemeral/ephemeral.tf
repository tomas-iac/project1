
resource "azurerm_resource_group" "test" {
  name     = "project1-ephemeral-base-rg"
  location = "westeurope"
}

resource "azurerm_virtual_network" "test" {
  name                = "test-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

// DNS zone
resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "test"
  resource_group_name   = azurerm_resource_group.test.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.test.id
}

resource "azurerm_private_dns_zone" "aks" {
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks" {
  name                  = "test"
  resource_group_name   = azurerm_resource_group.test.name
  private_dns_zone_name = azurerm_private_dns_zone.aks.name
  virtual_network_id    = azurerm_virtual_network.test.id
}

// Monitoring
resource "azurerm_log_analytics_workspace" "test" {
  name                = "test-kjahsdfkjhd37454382"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


