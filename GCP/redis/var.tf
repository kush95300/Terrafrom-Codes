## Default Varaible
variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "asia-south1"
    description = "The Google Cloud region to use"
}


## Network varaibles

# VPC
variable "vpc_name" {
  default = "kaushal-vpc"
  description = "value of the vpc network name"
}

# REDIS

variable "redis_name" {
  default = "kaushal-redis"
  description = "value of the redis name"
}

variable "redis_memory_size_gb" {
  default = "5"
  description = "value of the redis memory size"
}

variable "tier" {
  default = "STANDARD_HA"
  description = "value of the tier"  
}

variable "auth_enabled" {
  default = true
  description = "value of the auth_enabled"  
}

variable "replica_count" {
  default = 2
  description = "value of the replica_count"  
}
  
variable "read_replicas_mode" {
    default = "READ_REPLICAS_ENABLED"
    description = "value of the read_replicas_mode"  
}

variable "connect_mode" {
    default = "PRIVATE_SERVICE_ACCESS"
    description = "value of the connect_mode"  
  
}

variable "labels" {
    default = {
      "owner" = "kaushal"
      "do-not-delete" = "true"
    }
    description = "The labels to use"
}
