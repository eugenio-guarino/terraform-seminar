resource "google_compute_firewall" "firewall_allow" {
  name       = var.firewall-name
  network    = var.vpc-name
  depends_on = [var.firewall_depends_on]

  direction  = var.firewall_direction
  priority   = var.firewall_priority
  
  allow {
    protocol = (var.allow_protocol == "" ? null : var.allow_protocol)
    ports    = (var.allow_ports == [""] ? null : var.allow_ports)
  }

  destination_ranges        = (var.dest_ranges == [""] ? null : var.dest_ranges)
  source_ranges             = (var.src_ranges == [""] ? null : var.src_ranges)
  source_service_accounts   = (var.src_service_accounts == [""] ? null : var.src_service_accounts)
  source_tags               = (var.src_tags == [""] ? null : var.src_tags)
  target_service_accounts   = (var.tar_service_accounts == [""] ? null : var.tar_service_accounts)
  target_tags               = (var.tar_tags == [""] ? null : var.tar_tags)
}