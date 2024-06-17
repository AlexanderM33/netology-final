
Оптимизировать код можно следающим образом:
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

И создавать их в network.tf про помощи цикла

