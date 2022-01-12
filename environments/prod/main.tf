module "main" {
  source            = "../../terraform/"
  environment       = "prod"
  namePrefix        = "project1"
  location          = "westeurope"
  vnetName          = "tom-sub02-vnet"
  vnetResourceGroup = "tom-sub02-rg"
}
