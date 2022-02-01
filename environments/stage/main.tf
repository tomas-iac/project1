module "main" {
  source               = "../../terraform/"
  environment          = "stage"
  namePrefix           = "project1"
  location             = "westeurope"
  vnetName             = "tom-sub03-vnet"
  vnetResourceGroup    = "tom-sub03-rg"
  subnetPrefixAks      = "10.2.0.0/22"
  subnetPrefixServices = "10.2.4.0/24"
}
