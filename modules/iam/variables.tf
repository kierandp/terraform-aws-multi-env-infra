variable "role_name" {
  type = string
}

variable "assume_role_policy" {
  type = any
}

variable "policy" {
  type = any
}

variable "tags" {
  type = map(string)
}