module "main" {
  source      = "../../terraform/"
  environment = "stage"
  namePrefix  = "project1"
  location    = "westeurope"
}
