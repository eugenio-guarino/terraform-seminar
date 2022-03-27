resource "google_compute_disk" "default" {
  name  = var.data-disk-name
  type  = var.data-disk-type
  size  = var.data-disk-size
  zone  = var.zone
}