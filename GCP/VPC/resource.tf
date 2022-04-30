### NETWORKING 

# VPC
resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
  description = "VPC network by Terraform"
  auto_create_subnetworks = "false"
  routing_mode = var.vpc_routing_mode
}

# Subnets
resource "google_compute_subnetwork" "vpc_subnetwork" {
  count = length(var.vpc_subnetwork_names)
  name = var.vpc_subnetwork_names[count.index]
  description = "VPC subnetwork by Terraform"
  ip_cidr_range = var.vpc_subnetwork_ip_cidr_ranges[count.index]
  network = google_compute_network.vpc_network.id
  region = var.vpc_subnetwork_region_list[count.index]
}

# Router 
resource "google_compute_router" "vpc_router" {
  name    = var.vpc_router_name
  region  = google_compute_subnetwork.vpc_subnetwork[0].region
  network = google_compute_network.vpc_network.id
}

# NAT
resource "google_compute_router_nat" "vpc_router_nat" {
  name                               = var.vpc_router_nat_name
  router                             = google_compute_router.vpc_router.name
  region                             = google_compute_router.vpc_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

#   log_config {
#     enable = true
#     filter = "ERRORS_ONLY"
#   }
}

# Firewall rules
resource "google_compute_firewall" "default" {
  name    = "kaushal-firewall-terraform"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "5000"]
  }

  target_tags = ["web-tf"]
  source_ranges = [ "35.235.240.0/20" ]
}



