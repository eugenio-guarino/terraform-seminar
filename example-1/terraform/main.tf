# Create VPC network without default subnets
module "vpc" {
  source           = "./modules/vpc"
  vpc-name         = "NETWORK-NAME"
  auto-subnetworks = false
}

# Create Subnet in the VPC network
module "subnet" {
  source              = "./modules/subnet"
  subnet_depends_on   = [module.vpc]
  subnet-name         = "SUBNET-NAME"
  vpc-name            = "NETWORK-NAME"
  subnet-region       = "europe-west3"
  private-subnet-cidr = "10.156.0.0/20"
  google-access       = true
}

module "allow-lb" {
  source              = "./modules/firewall_allow"
  vpc-name            = "NETWORK-NAME"
  firewall-name       = "allow-lb"
  firewall_depends_on = [module.vpc]

  firewall_direction = "INGRESS" # define INGRESS or EGRESS for firewall IN or OUT traffic.
  # For INGRESS traffic, it is NOT supported to specify dest_ranges.
  # For EGRESS traffic, it is NOT supported to specify sour_ranges OR sour_service_accounts.

  firewall_priority = "1000"

  allow_protocol = "tcp"
  allow_ports    = [""] #allow_ports    = ["80", "443"] # Note: If you want icmp protocol then leave the list empty like this -- allow_ports = [""] --

  dest_ranges          = [""]                                # Specify only if firewall_direction  = "EGRESS"
  src_ranges           = ["130.211.0.0/22", "35.191.0.0/16"] # Specify only if firewall_direction  = "INGRESS"
  src_service_accounts = [""]
  src_tags             = [""] # Specify only if firewall_direction  = "INGRESS"
  tar_service_accounts = [""]
  tar_tags             = ["allow-lb"]
}

module "allow-iap" {
  source              = "./modules/firewall_allow"
  vpc-name            = "NETWORK-NAME"
  firewall-name       = "allow-iap"
  firewall_depends_on = [module.vpc]

  firewall_direction = "INGRESS" # define INGRESS or EGRESS for firewall IN or OUT traffic.
  # For INGRESS traffic, it is NOT supported to specify dest_ranges.
  # For EGRESS traffic, it is NOT supported to specify sour_ranges OR sour_service_accounts.

  firewall_priority = "1000"

  allow_protocol = "tcp"
  allow_ports    = ["22", "3389"] #allow_ports    = ["80", "443"] # Note: If you want icmp protocol then leave the list empty like this -- allow_ports = [""] --

  dest_ranges          = [""]                # Specify only if firewall_direction  = "EGRESS"
  src_ranges           = ["35.235.240.0/20"] # Specify only if firewall_direction  = "INGRESS"
  src_service_accounts = [""]
  src_tags             = [""] # Specify only if firewall_direction  = "INGRESS"
  tar_service_accounts = [""]
  tar_tags             = ["allow-iap"]
}

# Allow anonymous (created by Abdel for testing, should be deleted after)
module "allow-rdp" {
  source              = "./modules/firewall_allow"
  vpc-name            = "NETWORK-NAME"
  firewall-name       = "allow-rdp"
  firewall_depends_on = [module.vpc]

  firewall_direction = "INGRESS" # define INGRESS or EGRESS for firewall IN or OUT traffic.
  # For INGRESS traffic, it is NOT supported to specify dest_ranges.
  # For EGRESS traffic, it is NOT supported to specify sour_ranges OR sour_service_accounts.

  firewall_priority = "1000"

  allow_protocol = "tcp"
  allow_ports    = ["3389"] #allow_ports    = ["3389","80", "443"] # Note: If you want icmp protocol then leave the list empty like this -- allow_ports = [""] --

  dest_ranges          = [""]              # Specify only if firewall_direction  = "EGRESS"
  src_ranges           = ["102.84.60.221"] # Specify only if firewall_direction  = "INGRESS"
  src_service_accounts = [""]
  src_tags             = [""] # Specify only if firewall_direction  = "INGRESS"
  tar_service_accounts = [""]
  tar_tags             = ["allow-rdp"]
}

# Deny INGRESS Firewall ALL
module "deny-all" {
  source              = "./modules/firewall_deny"
  vpc-name            = "NETWORK-NAME"
  firewall-name       = "deny-all"
  firewall_depends_on = [module.vpc]

  firewall_direction = "INGRESS" # define INGRESS or EGRESS for firewall IN or OUT traffic.
  # For INGRESS traffic, it is NOT supported to specify dest_ranges.
  # For EGRESS traffic, it is NOT supported to specify sour_ranges OR sour_service_accounts.

  firewall_priority = "65533"

  deny_protocol = "all"
  deny_ports    = [""] # Note: If you want icmp protocol then leave the list empty like this -- allow_ports = [""] --

  dest_ranges          = [""]          # Specify only if firewall_direction  = "EGRESS"
  src_ranges           = ["0.0.0.0/0"] # Specify only if firewall_direction  = "INGRESS"
  src_service_accounts = [""]
  src_tags             = [""] # Specify only if firewall_direction  = "INGRESS"
  tar_service_accounts = [""]
  tar_tags             = [""]
}

# Allow INGRESS Firewall TCP 80, 443 for health check, load balancer and IAP
module "allow-internal" {
  source              = "./modules/firewall_allow"
  vpc-name            = "NETWORK-NAME"
  firewall-name       = "allow-internal"
  firewall_depends_on = [module.vpc]

  firewall_direction = "INGRESS" # define INGRESS or EGRESS for firewall IN or OUT traffic.
  # For INGRESS traffic, it is NOT supported to specify dest_ranges.
  # For EGRESS traffic, it is NOT supported to specify sour_ranges OR sour_service_accounts.

  firewall_priority = "1000"

  allow_protocol = "all"
  allow_ports    = [""] #allow_ports    = ["80", "443"] # Note: If you want icmp protocol then leave the list empty like this -- allow_ports = [""] --

  dest_ranges          = [""]              # Specify only if firewall_direction  = "EGRESS"
  src_ranges           = ["10.156.0.0/20"] # Specify only if firewall_direction  = "INGRESS"
  src_service_accounts = [""]
  src_tags             = [""] # Specify only if firewall_direction  = "INGRESS"
  tar_service_accounts = [""]
  tar_tags             = ["allow-internal"]
}
