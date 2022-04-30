# instances

resource "google_compute_instance" "vms" {
  count = var.instance_count
  name         = "${var.instance_name}-${count.index}"
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

  metadata_startup_script =  var.script_path == "" ? "" : file("${path.module}/${var.script_path}")

#   service_account {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = google_service_account.default.email
#     scopes = ["cloud-platform"]
#   }
}

# Un-managed instance group
resource "google_compute_instance_group" "webservers" {
  name        = "${var.instance_name}-instance-group"
  description = "Terraform test instance group"

  instances = google_compute_instance.vms.*.id
  
  zone = "${var.region}-a"
}

# Health check
resource "google_compute_health_check" "webserver-hc" {
  name               = "${var.instance_name}-hc"
  description        = "Terraform test HTTP health check"
  check_interval_sec = "5"
  timeout_sec        = "5"
  healthy_threshold  = "2"
  unhealthy_threshold = "2"
  http_health_check {
    port = "80"
  }

}

# backend service
resource "google_compute_backend_service" "backend_service" {
  name        = "${var.instance_name}-backend-service"
  description = "Terraform test backend service"

  health_checks = [google_compute_health_check.webserver-hc.id]

  port_name = "http"
  timeout_sec = "30"
  protocol = "HTTP"
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_instance_group.webservers.id
  }
  depends_on = [
    google_compute_health_check.webserver-hc
  ]
}

# Frontend rule
resource "google_compute_forwarding_rule" "frontend_rule" {
  name        = "${var.instance_name}-frontend-rule"
  description = "Terraform test frontend rule"

  port_range = "80"

  backend_service = google_compute_backend_service.backend_service.id
}