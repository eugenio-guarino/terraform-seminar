region = "REGION"

# VPC Network configuration
network        = "NETWORK-NAME"
subnet         = "SUBNET-NAME"
subnet-project = "PROJECT-NAME"

# IP address configuration
ip-name      = "IP-ADDRESS-NAME"
network-tier = "PREMIUM"
address-type = "EXTERNAL"
zone         = "ZONE"

# Compute Engine configuration
machine-type           = "n1-standard-8"
instance-name          = "INSTANCE-NAME"
startup-script         = "./startup-script.sh"
allow-stop-updates     = true
boot-disk-image        = "ubuntu-os-cloud/ubuntu-2004-lts"
boot-disk-size         = 50
service-account        = "000000000000-compute@developer.gserviceaccount.com"
service-account-scopes = ["cloud-platform"]
network-tags           = ["NETWORK-TAG-1", "NETWORK-TAG-2", "NETWORK-TAG-3"]
