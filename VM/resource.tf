resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = "${var.region }-a"

  tags = var.network_tags
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

  #metadata_startup_script = "echo hi > /test.txt"

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = google_service_account.default.email
#     scopes = ["cloud-platform"]
#   }
}