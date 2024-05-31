resource "yandex_compute_instance" "control" {
  count = 1
  name = "control-${count.index}"
  zone  = "${var.subnet-zones[count.index]}"



  resources {
    cores  = 4
    memory = 8
  }
  scheduling_policy {
  preemptible = true  
  }
  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet-zones[count.index].id}"
    nat        = true
  }
  boot_disk {
    initialize_params {
      image_id = "fd8re3hiqnikqr7j7m8s"
      type     = "network-ssd"
      size     = "50"
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker" {
  count = 2
  name  = "worker-${count.index}"
  zone  = "${var.subnet-zones[count.index]}"
 scheduling_policy {
  preemptible = true 
  }
 labels = {
    index = "${count.index}"
  }
  resources {
    cores  = 4
    memory = 8
  }
network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet-zones[count.index].id}"
    nat        = true
  }


  boot_disk {
    initialize_params {
      image_id = "fd8re3hiqnikqr7j7m8s"
      type     = "network-ssd"
      size     = "50"
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
