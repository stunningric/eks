variable "region" {
  default = "us-east-2"
}

variable "ami" {
  default = "ami-05fb0b8c1424f266b"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "rc-demo"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "public-subnet" {
  type    = list(string)
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private-subnet" {
  type    = list(string)
  default = ["10.0.32.0/20", "10.0.48.0/20"]
}

variable "availability-zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b"]
}
