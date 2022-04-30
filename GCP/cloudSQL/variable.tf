## Default Varaible
variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "asia-south1"
    description = "The Google Cloud region to use"
}

variable "vpc_name" {
    default = "kaushal-vpc"
    description = "The Google Cloud VPC to use"
  
}

## SQL Version
variable "sql_version" {
    default = "MYSQL_5_7"
    description = "The SQL Version to use"
}

variable "sql_root_password" {
    description = "The SQL Root Password to use"
    default = "MySql@123"  # Default Password
    sensitive = true
}

variable "disk_machine_type" {
    default = "db-n1-standard-1"
    description = "The SQL Disk Machine Type to use"    
}

variable "disk_size" {
    default = "10"
    description = "The SQL Disk Size to use"
}

variable "disk_type" {
    default = "PD_HDD"
    description = "The SQL Disk Type to use"
}

variable "availability_type" {
    default = "ZONAL"
    description = "The SQL Availability Type to use"
}

variable "autoresize_disk" {
    default = "false"
    description = "The SQL Autoresize Disk to use"
}


variable "read_replica_count" {
    default = "1"
    description = "The SQL Read Replica Count to use"
}

variable "read_replica_zones" {
    default = ["asia-south1-b"]
    type = list
    description = "The SQL Read Replica Zones to use"
}

variable "labels" {
    default = {
      "owner" = "kaushal"
      "do-not-delete" = "true"
    }
    description = "The labels to use"
}

# SAMPLE DB
variable "sample_db_name" {
    default = ""     # Default: "kush-tf-sample-db"
    description = "The SQL Database Name to use"
}

# DB USER
variable "create_user" {
    default = "true"
    description = "The SQL Create User to use"
}

variable "sql_user_name" {
    default = "myuser"    # Default : "myuser"
    description = "The SQL User Name to use"
}

variable "sql_user_password" {
    description = "The SQL User Password to use"
    default = "pass123"    # Default password
    sensitive = true
}