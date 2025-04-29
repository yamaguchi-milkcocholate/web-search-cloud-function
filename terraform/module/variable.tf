variable "project_id" {
  description = "Google Cloud プロジェクト ID"
  type        = string
}

variable "project_number" {
  description = "Google Cloud プロジェクト No"
  type        = string
}

variable "region" {
  description = "Google Cloud リージョン"
  type        = string
  default     = "asia-northeast1"
}
