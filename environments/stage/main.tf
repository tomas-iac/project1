module "main" {
  source               = "../../terraform" # stage is always from main, no pinning or branching
  environment          = "stage"
  namePrefix           = "project1"
  location             = "eastus2"
  privateDnsZoneIdAks  = "/subscriptions/a0f4a733-4fce-4d49-b8a8-d30541fc1b45/resourceGroups/tom-dns-rg/providers/Microsoft.Network/privateDnsZones/privatelink.eastus2.azmk8s.io"
  vnetName             = "tom-sub03-vnet"
  vnetResourceGroup    = "tom-sub03-rg"
  subnetPrefixAks      = "10.2.0.0/22"
  subnetPrefixServices = "10.2.4.0/24"
  dbSku                = "GP_Gen5_2"
  kubernetesVmSize     = "Standard_B4ms"
  kubernetesNodeCount  = 1
}
