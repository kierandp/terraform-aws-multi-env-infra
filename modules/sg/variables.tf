variable "vpc_id" {
  type = string
}

variable "alb_ingress_ports" {
  type = list(number)
}

variable "app_port" {
  type = number
}

variable "db_port" {
  type = number
}

variable "tags" {
  type = map(string)
}