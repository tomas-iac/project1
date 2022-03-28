module "main" {
  source               = "../../terraform" # stage is always from main, no pinning or branching
  environment          = "stage"
  namePrefix           = "project1"
  location             = "northeurope"
  vnetName             = "tom-sub03-vnet"
  vnetResourceGroup    = "tom-sub03-rg"
  subnetPrefixAks      = "10.2.0.0/22"
  subnetPrefixServices = "10.2.4.0/24"
  dbSku                = "GP_Gen5_2"
}
