
// Resource group
resource "azurerm_resource_group" "project1" {
  name     = "${var.namePrefix}-${var.environment}-rg"
  location = var.location
}

// Add subnet for AKS
resource "azurerm_subnet" "aks" {
  name                                           = "${var.namePrefix}-${var.environment}-aks-subnet"
  resource_group_name                            = var.vnetResourceGroup
  virtual_network_name                           = var.vnetName
  address_prefixes                               = [var.subnetPrefixAks]
  enforce_private_link_endpoint_network_policies = true
}

// Add subnet for services
resource "azurerm_subnet" "services" {
  name                                           = "${var.namePrefix}-${var.environment}-services-subnet"
  resource_group_name                            = var.vnetResourceGroup
  virtual_network_name                           = var.vnetName
  address_prefixes                               = [var.subnetPrefixServices]
  enforce_private_link_endpoint_network_policies = true
}

// Add UDR (for AKS provisioning to work in vWAN topology)
resource "azurerm_route_table" "aks" {
  count                         = var.outboundType == "userDefinedRouting" ? 1 : 0
  name                          = "${var.namePrefix}-${var.environment}-aks-routes"
  location                      = var.location
  resource_group_name           = var.vnetResourceGroup
  disable_bgp_route_propagation = false

  route {
    name                   = "allViaFW"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.255.64.4"
  }
}

resource "azurerm_subnet_route_table_association" "aks" {
  count          = var.outboundType == "userDefinedRouting" ? 1 : 0
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.aks[0].id
}

// AKS
module "aks" {
  source                  = "github.com/tomas-iac/tm-aks//terraform/?ref=0.0.7"
  name                    = "${var.namePrefix}-${var.environment}"
  location                = azurerm_resource_group.project1.location
  resourceGroupName       = azurerm_resource_group.project1.name
  subnetId                = azurerm_subnet.aks.id
  vmSize                  = "Standard_B2s"
  nodeCount               = 1
  identityId              = azurerm_user_assigned_identity.aks.id
  identityClientId        = azurerm_user_assigned_identity.aks.client_id
  identityObjectId        = azurerm_user_assigned_identity.aks.principal_id
  outboundType            = var.outboundType
  privateCluster          = true
  privateDnsZoneId        = var.privateDnsZoneIdAks
  enableMonitoring        = true
  enableAudit             = true
  logAnalyticsWorkspaceId = var.logAnalyticsWorkspaceId

  depends_on = [
    azurerm_role_assignment.aks-network,
    azurerm_role_assignment.aks-project1,
    azurerm_subnet_route_table_association.aks,
    azurerm_subnet.aks
  ]
}

// SQL
module "sql" {
  source                  = "github.com/tomas-iac/tm-azuresql//terraform/?ref=0.0.4"
  serverName              = "${var.namePrefix}-${var.environment}-tomsqlsrv"
  dbName                  = "mydb"
  resourceGroupName       = azurerm_resource_group.project1.name
  location                = azurerm_resource_group.project1.location
  subnetId                = azurerm_subnet.services.id
  privateDnsZoneId        = var.privateDnsZoneIdSql
  adminUsername           = "tomas"
  adminPassword           = "Azure12345678"
  sku                     = var.dbSku
  logAnalyticsWorkspaceId = var.logAnalyticsWorkspaceId
  enableMonitoring        = true
}

  // ZMENA
