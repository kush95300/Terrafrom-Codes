## Default Varaible
variable "project_id" {
  default = "searce-playground-v1"
  description = "The Google Cloud project ID to use"
}

variable "region" {
    default = "asia-south1"
    description = "The Google Cloud region to use"
}

# IAM
variable "iam_role_name" {
  default = "kush_role_tf"
  description = "value of the iam role name"
}

variable "iam_role_permissions" {
  default = ["container.services.get"]
  description = "value of the iam role permissions"
}

variable "service_account_name" {
  default = "tf-kush"
  description = "value of the service account name"
}
 