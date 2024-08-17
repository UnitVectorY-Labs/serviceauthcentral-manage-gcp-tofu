# Enable required APIs for Cloud Run and Firestore
resource "google_project_service" "run" {
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "firestore" {
  project            = var.project_id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

# Service account for Cloud Run services
resource "google_service_account" "cloud_run_sa" {
  project      = var.project_id
  account_id   = "sacmcr-${var.name}"
  display_name = "serviceauthcentral Cloud Run (${var.name}) service account"
}

# IAM role to grant Firestore write permissions to Cloud Run service account
resource "google_project_iam_member" "firestore_writer_role" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

locals {
  final_artifact_registry_project_id = coalesce(var.artifact_registry_project_id, var.project_id)
}

# Deploy Cloud Run services in specified regions
resource "google_cloud_run_v2_service" "serviceauthcentral-manage" {
  for_each = toset(var.regions)
  project  = var.project_id
  location = each.value
  name     = "${var.name}-manage-${each.value}"
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = google_service_account.cloud_run_sa.email

    containers {
      image = "${var.artifact_registry_host}/${local.final_artifact_registry_project_id}/${var.artifact_registry_name}/unitvectory-labs/serviceauthcentral-manage:${var.serviceauthcentral_manage_tag}"

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = "${var.name}-${each.value}"
      }
      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "prod,datamodel-gcp,datamodel-firestore"
      }
      env {
        name  = "SAC_ISSUER"
        value = var.sac_issuer
      }
      env {
        name  = "SAC_CORS_ORIGINS"
        value = var.sac_cors_origins
      }
    }
  }
}
