# Project 1
This repo describes infrastructure for Project 1 in two environments - staging and prod.

It is designed as module nesting other modules with services such as AKS or AzureSQL. 

Folder environments contains root for production and staging in order to isolate state files and allow for different provider configurations (to target different subscriptions or even tenants).

## Deploy

```bash
cd environments/staging   # Deploy staging environment
terraform init
terraform validate
terraform plan
terraform apply
```# project1
