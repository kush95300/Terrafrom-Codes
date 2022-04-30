output "vms" {
    value = google_compute_instance.vms
    sensitive = true
  
}
output "hc" {
    value = google_compute_health_check.webserver-hc
  
}

output "backend_service" {
    value = google_compute_backend_service.backend_service
  

  
}