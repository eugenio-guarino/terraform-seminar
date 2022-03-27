resource "google_compute_address" "default" {
  name         = var.name
  address_type = var.address-type
  network_tier = var.network-tier
  region       = var.region
}
