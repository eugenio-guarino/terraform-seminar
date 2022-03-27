module "network" {
  source  = "./modules/network"
  network = var.network
  subnet  = var.subnet
}

module "disk" {
  source         = "./modules/disk"
  data-disk-name = var.data-disk-name
  data-disk-type = var.data-disk-type
  zone           = var.zone
  data-disk-size = var.data-disk-size
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
  name                   = var.instance-name
  machine-type           = var.machine-type
  allow-stop-updates     = var.allow-stop-updates
  network-tags           = var.network-tags
  boot-disk-image        = var.boot-disk-image
  boot-disk-size         = var.boot-disk-size
  network                = module.network.network
  subnet                 = module.network.subnet
  subnet-project         = var.subnet-project
  nat-ip                 = module.instance-ip-address.ip_addr
  zone                   = var.zone
  dependson              = [module.network, module.instance-ip-address]
  service-account        = var.service-account
  service-account-scopes = var.service-account-scopes
}

module "attached-disk" {
  source     = "./modules/attached_disk"
  depends_on = [module.disk, module.instance]
  disk       = module.disk.disk
  instance   = module.instance.instance_url
}

