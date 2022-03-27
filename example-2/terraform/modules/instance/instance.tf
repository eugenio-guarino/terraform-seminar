resource "google_compute_instance" "default" {
  name                      = var.name
  machine_type              = var.machine-type
  zone                      = var.zone
  allow_stopping_for_update = var.allow-stop-updates
  depends_on                = [var.dependson]
  tags                      = var.network-tags

  boot_disk {
    initialize_params {
      image = var.boot-disk-image
      size  = var.boot-disk-size
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnet
    subnetwork_project = var.subnet-project

    access_config {
      nat_ip = var.nat-ip
    }
  }

  service_account {
    email  = var.service-account
    scopes = var.service-account-scopes
  }

  metadata = {
    # Enable compute os-login GCP role at instance level
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = file(var.startup-script)
}