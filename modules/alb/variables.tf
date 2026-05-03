variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)   # public subnets only
}

variable "sg_id" {
  type = string
}

variable "target_port" {
  type = number
}

variable "listener_port" {
  type = number
}

variable "tags" {
  type = map(string)
}