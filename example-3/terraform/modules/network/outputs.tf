output "network" {
  value = data.google_compute_network.default.self_link
}

output "subnet" {
  value = data.google_compute_subnetwork.default.self_link
}
