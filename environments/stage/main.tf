module "main" {
  source            = "../../terraform/"
  environment       = "stage"
  namePrefix        = "project1"
  location          = "westeurope"
  vnetName          = "tom-sub03-vnet"
  vnetResourceGroup = "tom-sub03-rg"
}
