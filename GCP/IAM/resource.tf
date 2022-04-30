# Random String
resource "random_string" "random" {
  length           = 4
  upper = false
  special          = false
}

locals {
    random = "${random_string.random.result}"
    iam_role_id = "${var.iam_role_name}_${local.random}"
    iam_service_account_id = "${var.service_account_name}-${local.random}"
}


# IAM Role
resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = local.iam_role_id
  title       = var.iam_role_name
  description = "A role creataed using terraform"
  permissions = var.iam_role_permissions
}

# IAM SERVICE ACCOUNT
resource "google_service_account" "sa" {
  account_id   = local.iam_service_account_id
  display_name = "${var.iam_role_name}_service_account"
  project      = var.project_id
}

# IAM Role Binding

// For Single Member
resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.sa.name
  role               = google_project_iam_custom_role.my-custom-role.name

  member ="user:kaushal.soni@searce.com"
  
}

// For Multiple Members
# resource "google_service_account_iam_binding" "admin-account-iam" {
#   service_account_id = google_service_account.sa.name
#   role               = google_project_iam_custom_role.my-custom-role.name

#   members = [
#     "user:kaushal.soni@searce.com",
#   ]
# }