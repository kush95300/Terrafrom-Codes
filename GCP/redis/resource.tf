resource "random_id" "name" {
    byte_length  = 4
  
}

# local
locals {
    network = "projects/${var.project_id}/global/networks/${var.vpc_name}"
    redis_display_id = "${var.redis_name}-${random_id.name.hex}"
    redis_display_name = "${var.redis_name}"
}

# REDIS
resource "google_redis_instance" "cache" {
    name           = local.redis_display_id
    memory_size_gb = var.redis_memory_size_gb
    tier = var.tier
    auth_enabled = var.auth_enabled
    authorized_network = local.network
    project = var.project_id
    region = var.region
    connect_mode = var.connect_mode
    display_name = local.redis_display_name
    labels = var.labels
    replica_count = var.replica_count
    read_replicas_mode = var.read_replicas_mode
}
