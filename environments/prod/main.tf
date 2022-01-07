module "main" {
  source      = "../../terraform/"
  environment = "prod"
  namePrefix  = "project1"
  location    = "westeurope"
}
