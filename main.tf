provider "azurerm" {
    features {}
}

module "vnet" {
  source  = "app.terraform.io/kevindemos/custom-vnet/azure"
  version = "1.0.0"

  identifier = var.identifier
  location = var.location
}

module "blob" {
  source  = "app.terraform.io/kevindemos/custom-blob/azure"
  version = "1.0.0"

  location = var.location
  res_group_name = module.vnet.res_group_name
}

module "custom_vm" {
  source  = "app.terraform.io/kevindemos/custom-vm/azure"
  version = "1.0.0"

  identifier = var.identifier
  linux_password = var.linux_password
  linux_user = var.linux_user
  location = var.location
  res_group_name = module.vnet.res_group_name
  storage_endpoint = module.blob.storage_endpoint
  subnet_id = var.subnet_id
  vm_size = var.vm_size
}
