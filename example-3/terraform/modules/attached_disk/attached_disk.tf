resource "google_compute_attached_disk" "default" {
  disk     = var.disk
  instance = var.instance
}
