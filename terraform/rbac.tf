// Identity and RBAC
resource "azurerm_user_assigned_identity" "aks" {
  name                = "${var.namePrefix}-${var.environment}-aks-identity"
  location            = azurerm_resource_group.project1.location
  resource_group_name = azurerm_resource_group.project1.name
}

resource "azurerm_role_assignment" "aks-project1" {
  scope                = azurerm_resource_group.project1.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

data "azurerm_virtual_network" "project1" {
  resource_group_name  = var.vnetResourceGroup
  name                 = var.vnetName
}

resource "azurerm_role_assignment" "aks-network" {
  scope                = data.azurerm_virtual_network.project1.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}


