### Ответы на дополнительные вопросы об оптимизации кода терреформа и ингресс-контроллере:


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

И создавать их в network.tf про помощи цикла `for_each`:
https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

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

Либо также оптимизировать код можно при помощи count.index таким образом:
Пример:
```
resource "yandex_vpc_network" "vpc" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "subnet_zones" {
  count          = 3
  name           = "subnet-${var.subnet_zone[count.index]}"
  zone           = var.subnet_zone[count.index]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["${var.cidr[count.index]}"]
}
```

### Второй вопрос (о NodePort)

Для того, чтобы избавиться от сервиса NodePort c ручным вводом порта для доступа к приложению, разверну в кластере ingress контроллер
В ходе выполнения воспользовался установкой при помощи Helm
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx

```

Применил
```
kubectl apply -f ingress.yaml
```

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: entry-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - host: "app.diplom.ru"
    http:
      paths:
      - pathType: Prefix
        backend:
          service:
            name: app-svc
            port:
              number: 80
        path: /
  - host: "grafana.diplom.ru"
    http:
      paths:
      - pathType: Prefix
        backend:
          service:
            name: grafana-svc
            port:
              number: 80
        path: /
```

Так как нет своего домена прописал внешний IP в `/etc/hosts`

```

[XXX.XXX.XXX.XXX] app.diplom.ru
[XXX.XXX.XXX.XXX] grafana.diplom.ru
```

![1001](https://github.com/AlexanderM33/netology-final/assets/122460278/723722ff-402a-4967-8180-1e155032d2c8)

![1002](https://github.com/AlexanderM33/netology-final/assets/122460278/0555a0fa-a650-42ae-84c5-30e7756445e0)

![1003](https://github.com/AlexanderM33/netology-final/assets/122460278/bdeb29a6-d41a-4ed1-985a-831b863d20e8)

![1004](https://github.com/AlexanderM33/netology-final/assets/122460278/504d286c-68fb-4b3f-b874-b1c002cd6a8d)



