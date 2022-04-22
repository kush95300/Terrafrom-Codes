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
variable "vpc_network_name" {
  default = "terraform-vpc-kaushal"
  description = "value of the vpc network name"
}

variable "vpc_routing_mode" {
  default = "REGIONAL"
  description = "value of the vpc routing mode"
}

# SUBNET
variable "vpc_subnetwork_names" {
  default = ["terraform-vpc-kaushal-subnet-1", "terraform-vpc-kaushal-subnet-2"]
  description = "value of the vpc subnetwork name"
}

variable "vpc_subnetwork_region_list" {
  default = ["asia-south1","asia-south2"]
  description = "value of the vpc subnetwork region"
}

variable "vpc_subnetwork_ip_cidr_ranges" {
  default = ["10.0.0.0/24","10.0.2.0/24"]
  description = "value of the vpc subnetwork ip cidr range"
}

# ROUTER
variable "vpc_router_name" {
  default = "terraform-vpc-kaushal-router"
  description = "value of the vpc router name"
}

# NAT
variable "vpc_router_nat_name" {
  default = "terraform-vpc-kaushal-router-nat"
  description = "value of the vpc router nat name"
}