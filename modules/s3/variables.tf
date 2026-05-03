variable "bucket_name" {
  type = string
}

variable "versioning_enabled" {
  type = bool
}

variable "public_access_block" {
  type = bool
}

variable "enable_encryption" {
  type = bool
}

variable "force_destroy" {
  type = bool
}

variable "bucket_policy" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}

variable "iam_role_arn" {
  type    = string
  default = null
}