variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "sg_id" {
  type = string
}

variable "iam_instance_profile_name" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "tags" {
  type = map(string)
}