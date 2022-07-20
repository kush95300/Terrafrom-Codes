# cluster
resource "google_container_cluster" "primary" {
  count = length(var.node_pool_region)
  name     = "${var.cluster_name }-${ var.node_pool_region[count.index] }"
  location = var.region
  description = "Terraform test cluster"
  network = var.vpc_name
  resource_labels = var.labels
  subnetwork = var.subnet
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  node_locations = var.node_zones

}

# node
resource "google_container_node_pool" "primary_preemptible_nodes" {
  depends_on = [
    google_container_cluster.primary
  ]
  count = length(var.node_pool_region)
  
  name       = "${var.cluster_name}-node-pool-${count.index}"
  location   = element(var.node_pool_region, count.index)
  cluster    = element(google_container_cluster.primary.*.id , count.index)
  node_count = var.node_count

  node_locations = var.node_zones

  node_config {
    preemptible  = true
    machine_type =  "e2-standard-4" #"e2-medium"
    labels = var.labels
    tags = var.network_tags

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}