
Оптимизировать неудачный код:
```
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

```
можно следающим образом:
добавить в переменные подсети:
```
variable "subnets" {
  type = map(object({
    zone         = string
    cidr_block   = string
  }))
  default = {
    subnet_a = {
      zone       = "ru-central1-a"
      cidr_block = "10.0.0.0/24"
    }
    subnet_b = {
      zone       = "ru-central1-b"
      cidr_block = "10.0.1.0/24"
    }
    subnet_d = {
      zone       = "ru-central1-d"
      cidr_block = "10.0.2.0/24"
    }
  }
}

```

И создавать их в network.tf про помощи цикла:

```
resource "yandex_vpc_network" "diplom_vpc" {
  name = "net-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "subnet" {
  for_each   = var.subnets
  name       = "net_${each.key}_${terraform.workspace}"
  zone       = each.value.zone
  network_id = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [each.value.cidr_block]
}
```


Для того, чтобы избавиться от сервиса NodePort c ручным вводом порта для доступа к приложению, разверну в кластере ingress контроллер
В ходе выполнения воспользовался установкой при помощи Helm
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx

```


