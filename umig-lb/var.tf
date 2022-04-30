variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "asia-south1"
    description = "The Google Cloud region to use"
}

variable "instance_count" {
   default = 3
   description = "no of instance to create"
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
variable "instance_name" {
    default = "kaushal-vm-terraform"
    description = "The name of the instance to create"
}

variable "image" {
    default = "projects/debian-cloud/global/images/debian-10-buster-v20220406"
    description = "The name of the image to use"
}

variable "machine_type" {
    default = "e2-micro"
    description = "The name of the machine type to use"
}

variable "script_path" {
    default = "scripts/startup.sh"
    description = "The startup script path to run ( with reference to module path)"
}


