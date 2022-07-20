output "Connection_Command"{
    value = "gcloud container clusters get-credentials ${ google_container_cluster.primary[0].name } --region ${var.region} --project ${var.project_id}"
}

