# == Network == #
region         = "europe-west3"
network        = "NETWORK-NAME"
subnet         = "SUBNET-NAME"
subnet-project = "PROJECT-NAME"

# == IP address == #
ip-name      = "IP-NAME"
network-tier = "PREMIUM"
address-type = "EXTERNAL"

# == Instance == #
zone                   = "europe-west3-c"
machine-type           = "n2-standard-2"
instance-name          = "INSTANCE-NAME"
allow-stop-updates     = true
boot-disk-image        = "windows-cloud/windows-2019"
boot-disk-size         = 50
service-account        = "000000000000-compute@developer.gserviceaccount.com"
service-account-scopes = ["cloud-platform"]
network-tags           = ["NETWORK-TAG-1", "NETWORK-TAG-2"]

# == Data disk == #
data-disk-name = "DATA-DISK-NAME"
data-disk-type = "pd-standard"
data-disk-size = 300
