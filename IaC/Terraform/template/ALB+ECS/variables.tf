# ---------------------------
# 変数設定
# ---------------------------
variable "region" {
  default = "ap-northeast-1"
}
variable "az_a" {
  default = "ap-northeast-1a"
}
variable "az_c" {
  default = "ap-northeast-1c"
}

variable "app_name" {
  default = "template-app"
}
variable "environment" {
  default = "develop"
}

variable "allowed_cidr" {
  default = null
}


variable "ecs_task_update" {
  default = true
}

variable "access_key" {}
variable "secret_key" {}
variable "rds_password" {}
