terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.78.2"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "mishinan-diplom-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJEdxGVmTdh4kTvSpuxdSVE"
    secret_key = "YCPkbvWDNzE7-4wfL7hEjMHqmu8fhetbpP9Ds0ts"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = var.yandex_cloud_id
  folder_id                = var.yandex_folder_id
  zone                     = var.yandex_compute_default_zone
}
