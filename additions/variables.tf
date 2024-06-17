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


variable "instance_cores" {
  description = "Number of CPU cores"
  type        = map(number)
  default = {
    stage = 2
    prod  = 4
    other = 1
  }
}

variable "instance_memory" {
  description = "Number of memory (Gb)"
  type        = map(number)
  default = {
    stage = 4
    prod  = 8
    other = 2
  }
}

variable "instance_image_id" {
  description = "Image ID for instance"
  type        = string
  default     = "fd8oshj0osht8svg6rfs"
}

variable "folder_id" {
  default = "b1ggjo945v2iut372vlh"
}

variable "svc_account_id" {
  default = "ajeua1q7bcksfdcc14om"
}

variable "master_count" {
  type = map(number)
  default = {
    stage = 1
    prod  = 1
  }
}

variable "worker_count" {
  type = map(number)
  default = {
    stage = 2
    prod  = 5
  }
}