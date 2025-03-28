variable "project_name" {
  default = "basil-backend"
}

variable "region" {
  default = "us-east-1"
}

variable "container_port" {
  default = 8000
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}
