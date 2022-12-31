variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  default = "id_rsa"
}

variable "ssh_key" {
  default = "id_rsa.pub"
}

variable "grafana" {
  default = "grafana.sh"
}

variable "ami_id" {
  default = "ami-00b3e95ade0a05b9b"
}
