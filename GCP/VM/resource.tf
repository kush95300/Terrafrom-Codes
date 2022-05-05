locals {
  network_tags = concat(var.network_tags, ["kush-firewall-rule-tf-vm"])
}

output "test" {
  value = local.network_tags
  
}
# Custom-firewall-rule-for-GCP-VM
resource "google_compute_firewall" "firewall" {
  name = var.firewall_name
  network = var.vpc_name
  source_ranges = var.source_ranges
  allow{
      protocol = "tcp"
      ports = var.allow_tcp_ports
    }
  
  target_tags = ["kush-firewall-rule-tf-vm"]
}


# instance
resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = "${var.region }-a"

  tags = local.network_tags
  labels = var.labels


  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet

    access_config {
        # The IP address that will be assigned to the instance
        # from the secondary private ip range of the subnetwork.
        # Note: this is not the primary ip address of the instance.
        
      // Ephemeral public IP
    }
  }
  metadata = {
    enable-oslogin = "true"
  }

  metadata_startup_script =  var.script_path == "" ? "" : file("${path.module}/${var.script_path}")

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = google_service_account.default.email
#     scopes = ["cloud-platform"]
#   }
}