locals {
  kubernetes_namespace = "staging"
  service_account_name = "cloud-storage-sa"
}

resource "google_service_account" "cloud_storage_sa" {
  account_id = "cloud-storage-sa"
}

resource "google_project_iam_member" "cloud_storage_sa" {
  project = local.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.cloud_storage_sa.email}"
}

resource "google_service_account_iam_member" "cloud_storage_sa" {
  service_account_id = google_service_account.cloud_storage_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${local.project_id}.svc.id.goog[${local.kubernetes_namespace}/${local.service_account_name}]"
}
