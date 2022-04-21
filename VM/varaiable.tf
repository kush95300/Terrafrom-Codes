variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "us-central1"
    description = "The Google Cloud region to use"
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

variable "network-tags" {
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
