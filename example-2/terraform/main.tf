module "network" {
  source  = "./modules/network"
  network = var.network
  subnet  = var.subnet
}

module "instance-ip-address" {
  source       = "./modules/address"
  name         = var.ip-name
  address-type = var.address-type
  network-tier = var.network-tier
  region       = var.region
}

module "instance" {
  source                 = "./modules/instance"
  dependson              = [module.network, module.instance-ip-address]
  name                   = var.instance-name
  machine-type           = var.machine-type
  allow-stop-updates     = var.allow-stop-updates
  startup-script         = var.startup-script
  network-tags           = var.network-tags
  boot-disk-image        = var.boot-disk-image
  boot-disk-size         = var.boot-disk-size
  network                = module.network.network
  subnet                 = module.network.subnet
  nat-ip                 = module.instance-ip-address.ip_addr
  subnet-project         = var.subnet-project
  zone                   = var.zone
  service-account        = var.service-account
  service-account-scopes = var.service-account-scopes
}
