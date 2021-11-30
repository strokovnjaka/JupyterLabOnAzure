variable "prefix" {
  default = "ucJupyterLab"
  description = "The prefix which should be used for all resources"
}

variable "location" {
  default = "West Europe"
  description = "The Azure Region in which all resources should be created."
}

variable "clients" {
  default = []
  description = "Client IPs that can connect to the server"
}

variable "port" {
  default = "8080"
  description = "Port for the jupyter lab server"
}

variable "gitrepo" {
  default = "foosball.example.org/path/to/repo.git"
  description = "Git Repo address, https accessible"
}

variable "gituser" {
  default = "foosball"
  description = "Git user"
}

variable "gitpass" {
  default = "foosball"
  description = "Git access token (or, not recommended, password)"
}

locals {
  workdir = "${path.cwd}"
}
