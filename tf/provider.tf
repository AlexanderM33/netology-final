provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id                 = "b1gflle3e4lag2p2cmt8"
  folder_id                = "b1ggjo945v2iut372vlh"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  cloud {
    organization = "Alexander_M_MBZ"

    workspaces {
      name = "stage"
    }
  }
}