
// Resource group
resource "azurerm_resource_group" "project1" {
  name     = "${var.namePrefix}-${var.environment}-rg"
  location = var.location
}

// Add subnet for AKS
resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = var.vnetResourceGroup
  virtual_network_name = var.vnetName
  address_prefixes     = ["10.1.0.0/22"]
}

// Add UDR (for AKS provisioning to work in vWAN topology)
resource "azurerm_route_table" "aks" {
  name                          = "aks-route-table"
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
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.aks.id
}

// AKS
module "aks" {
  source            = "github.com/tomas-iac/tm-aks//terraform/?ref=0.0.4"
  name              = "${var.namePrefix}-${var.environment}"
  location          = azurerm_resource_group.project1.location
  resourceGroupName = azurerm_resource_group.project1.name
  subnetId          = azurerm_subnet.aks.id
  vmSize            = "Standard_B2s"
  identityId        = azurerm_user_assigned_identity.aks.id
  identityClientId  = azurerm_user_assigned_identity.aks.client_id
  identityObjectId  = azurerm_user_assigned_identity.aks.principal_id
  outboundType      = "userDefinedRouting"
  depends_on = [
    azurerm_role_assignment.aks-network,
    azurerm_role_assignment.aks-project1,
    azurerm_subnet_route_table_association.aks,
  ]
}
