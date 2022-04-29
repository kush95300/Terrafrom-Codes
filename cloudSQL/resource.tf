resource "random_id" "db_name_suffix" {
  byte_length = 4
}


locals {
  db_name_suffix = "${random_id.db_name_suffix.hex}"
  sql_instance_name = "kush-tf-${var.region}-${local.db_name_suffix}"
  sample_db_name = var.sample_db_name == "" ? "kush-tf-sample-db" : var.sample_db_name
  vpc = "projects/${var.project_id}/global/networks/${var.vpc_name}"
}

# SQL Instance: cloudSQL
resource "google_sql_database_instance" "master" {
  depends_on = [
    random_id.db_name_suffix
  ]
  name             = local.sql_instance_name
  database_version = var.sql_version
  region           = var.region
  root_password = var.sql_root_password
  project = var.project_id
  deletion_protection = false
  
  settings {
      backup_configuration {
      binary_log_enabled = true
      enabled = true
    }
    tier = var.disk_machine_type
    disk_size = var.disk_size
    disk_type = var.disk_type
    availability_type = var.availability_type
    disk_autoresize = var.autoresize_disk
    user_labels = var.labels

    ip_configuration {
      ipv4_enabled = false
      private_network = local.vpc
      require_ssl = false
    }
  }
}

# SQL Database: cloudSQL
resource "google_sql_database" "master_sample_db" {
  depends_on = [
    google_sql_database_instance.master
  ]
  name = local.sample_db_name
  project = var.project_id
  instance = google_sql_database_instance.master.name
}

# SQL DB USER: cloudSQL
resource "google_sql_user" "default" {
  depends_on = [google_sql_database.master_sample_db]
  count = var.create_user == "true" ? 1 : 0

  project  = var.project_id 
  name     = var.sql_user_name
  instance = google_sql_database_instance.master.name
  password = var.sql_user_password
}

# SQL Read Replica: cloudSQL
resource "google_sql_database_instance" "read_replica" {
  count = var.read_replica_count

  depends_on = [
    google_sql_database_instance.master,
    google_sql_database.master_sample_db,
    google_sql_user.default
  ]

  name             = "kush-tf-read-replica-${var.region}-${local.db_name_suffix}"
  project          = var.project_id
  region           = var.region
  database_version = var.sql_version

  # The name of the instance that will act as the master in the replication setup.
  master_instance_name = google_sql_database_instance.master.name

  replica_configuration {
    # Specifies that the replica is not the failover target.
    failover_target = false
  }

  settings {
    tier            = var.disk_machine_type
    disk_autoresize = var.autoresize_disk

    ip_configuration {
      ipv4_enabled    = false
      private_network = local.vpc
      require_ssl     = false
    }

    location_preference {
      zone = element(var.read_replica_zones, count.index)
    }

    disk_size = var.disk_size
    disk_type = var.disk_type

    user_labels = var.labels
  }

  deletion_protection = false

}
