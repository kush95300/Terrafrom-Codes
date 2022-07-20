variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "asia-south1"
    description = "The Google Cloud region to use"
}

variable "node_pool_region" {
    default = ["asia-south1"] #, "asia-south2"]
    description = "The Google Cloud region to use for the node pool"  
}

variable "node_zones" {
    default = ["asia-south1-a"]
    description = "The Google Cloud regions to use for nodes"
  
}

variable "node_count" {
    default = 1
    description = "The number of nodes to create in each node pool"
}

# labelling
variable "labels" {
    default = {
        "env" = "dev"
        "owner" = "kush"
    }
    description = "Labels to apply to the instance"
}

# Networking
variable "vpc_name" {
    default = "kaushal-vpc"

    description = "The name of the VPC to create"
}

variable "subnet" {
    default = "kaushal-subnet-1"
    description = "The name of the subnet to create"
}

variable "network_tags" {
    default = ["kaushal-ssh-icmp","kaushal-flask"]
    description = "The tags to apply to the network"
}

# Compute
variable "cluster_name" {
    default = "kaushal-gke-cluster"
    description = "The name of the instance to create"
}



