module "common" {
  source         = "../module"
  project_id     = "my-playground-458212"
  project_number = "1062902222689"
  region         = "asia-northeast1"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

provider "google" {
  project = module.common.project_id
  region  = module.common.region
}

# ソースコードを格納する GCS バケットの作成
resource "google_storage_bucket" "default" {
  name                        = "cloud-run-source-bucket"
  location                    = "ASIA-NORTHEAST1"
  uniform_bucket_level_access = true # ACLを無効にしてバケットレベルのアクセス制御を有効にする
}

data "archive_file" "default" {
  type        = "zip"
  output_path = "/tmp/function-source.zip"
  source_dir  = "../../function/"
}

# ソースコードを GCS バケットにアップロード
resource "google_storage_bucket_object" "object" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.default.name
  source = data.archive_file.default.output_path # Add path to the zipped function source code
}

resource "google_cloudfunctions2_function" "default" {
  name        = "web-search-cloud-function"
  location    = module.common.region
  description = "Web Search Cloud Function"

  build_config {
    runtime     = "python310"
    entry_point = "hello_get" # Set the entry point
    source {
      storage_source {
        bucket = google_storage_bucket.default.name
        object = google_storage_bucket_object.object.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }
}

resource "google_cloud_run_service_iam_member" "member" {
  project  = google_cloudfunctions2_function.default.project
  location = google_cloudfunctions2_function.default.location
  service  = google_cloudfunctions2_function.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "function_uri" {
  value = google_cloudfunctions2_function.default.service_config[0].uri
}
