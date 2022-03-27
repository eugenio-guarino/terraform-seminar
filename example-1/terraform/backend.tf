provider "google" {
  project               = var.project
  region                = var.region
}
# CHANGE will be replaced automatically with sed depending on which branch you are
terraform {
  backend "gcs" {}
}