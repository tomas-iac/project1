module "main" {
  source               = "github.com/tomas-iac/project1//terraform?ref=0.0.1"
  environment          = "prod"
  namePrefix           = "project1"
  location             = "westeurope"
  vnetName             = "tom-sub02-vnet"
  vnetResourceGroup    = "tom-sub02-rg"
  subnetPrefixAks      = "10.1.0.0/22"
  subnetPrefixServices = "10.1.4.0/24"
}
