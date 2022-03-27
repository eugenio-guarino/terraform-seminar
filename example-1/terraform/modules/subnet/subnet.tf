resource "google_compute_subnetwork" "private-subnet" {
  name                     = var.subnet-name
  ip_cidr_range            = var.private-subnet-cidr
  network                  = var.vpc-name
  region                   = var.subnet-region
  private_ip_google_access = var.google-access
  depends_on               = [var.subnet_depends_on]
     
  log_config {
    aggregation_interval   = "INTERVAL_5_SEC"
      flow_sampling        = 1.0
      metadata             = "INCLUDE_ALL_METADATA"
  }
}