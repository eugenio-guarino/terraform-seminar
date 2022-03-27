data "google_compute_network" "default" {
  name = var.network
}

data "google_compute_subnetwork" "default" {
  name = var.subnet
}