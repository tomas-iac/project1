module "main" {
  source               = "github.com/tomas-iac/project1//terraform?ref=0.0.1" # Main is pinned to release tag
  environment          = "prod"
  namePrefix           = "project1"
  location             = "eastus2"
  privateDnsZoneIdAks  = "/subscriptions/a0f4a733-4fce-4d49-b8a8-d30541fc1b45/resourceGroups/tom-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.eastus2.azmk8s.io"
  vnetName             = "tom-sub02-vnet"
  vnetResourceGroup    = "tom-sub02-rg"
  subnetPrefixAks      = "10.1.0.0/22"
  subnetPrefixServices = "10.1.4.0/24"
  dbSku                = "GP_Gen5_2"
}
