provider "google" {
  project     = var.project_id
  region      = var.region
  credentials   = file("~/.ssh/searce-key.json")
}

