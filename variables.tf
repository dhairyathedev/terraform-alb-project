variable "ami_id" {
  type    = string
  default = "ami-051a31ab2f4d498f5"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair_name" {
  type    = string
  default = "1password-sandbox-account-ap-south-1"
}
