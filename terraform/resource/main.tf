module "common" {
  source         = "../module"
  project_id     = "my-playground-458212"
  project_number = "1062902222689"
  region         = "asia-northeast1"
}

provider "google" {
  project = module.common.project_id
  region  = module.common.region
}

# サービスアカウントの作成
resource "google_service_account" "cloud_run_sa" {
  project      = module.common.project_id
  account_id   = "cloud-fun-sa"
  display_name = "Cloud Run Service Account"
  description  = "CloudRunに紐づけるサービスアカウント"
}

# サービスアカウントに必要な IAM ロールを付与
resource "google_service_account_iam_member" "by_cloudbuild" {
  service_account_id = google_service_account.cloud_run_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${module.common.project_number}@cloudbuild.gserviceaccount.com"
}
