# Create VPC no default subnetworks
resource "google_compute_network" "vpc" {
     name                    = var.vpc-name
     auto_create_subnetworks = var.auto-subnetworks
}