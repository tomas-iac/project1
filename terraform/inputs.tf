variable "location" {
  type = string
}

variable "namePrefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "vnetName" {
  type = string
}

variable "vnetResourceGroup" {
  type = string
}

variable "privateDnsZoneIdAks" {
  type    = string
  default = "/subscriptions/a0f4a733-4fce-4d49-b8a8-d30541fc1b45/resourceGroups/tom-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io"
}

variable "privateDnsZoneIdSql" {
  type    = string
  default = "/subscriptions/a0f4a733-4fce-4d49-b8a8-d30541fc1b45/resourceGroups/tom-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
}

variable "logAnalyticsWorkspaceId" {
  type    = string
  default = "/subscriptions/a0f4a733-4fce-4d49-b8a8-d30541fc1b45/resourceGroups/tom-shared-rg/providers/Microsoft.OperationalInsights/workspaces/tom-logs345345672"
}

variable "subnetPrefixAks" {
  type = string
}

variable "subnetPrefixServices" {
  type = string
}

variable "dbSku" {
  type = string
}

variable "outboundType" {
  type    = string
  default = "userDefinedRouting"
}

