resource "yandex_vpc_network" "diplom_vpc" {
  name = "net-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "diplom_subnet_a" {
  name       = "net_a_${terraform.workspace}"
  zone       = "ru-central1-a"
  network_id = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = [var.subnet_cidr_blocks[0]]
}

resource "yandex_vpc_subnet" "diplom_subnet_b" {
  name       = "net_b_${terraform.workspace}"
  zone       = "ru-central1-b"
  network_id = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = [var.subnet_cidr_blocks[1]]
}

resource "yandex_vpc_subnet" "diplom_subnet_c" {
  name       = "net_d_${terraform.workspace}"
  zone       = "ru-central1-d"
  network_id = yandex_vpc_network.diplom_vpc.id
  v4_cidr_blocks = [var.subnet_cidr_blocks[2]]
}