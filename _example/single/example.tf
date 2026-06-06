provider "google" {
  project = "vikas-474608"
  region  = "us-west1"
  zone    = "asia-northeast1-a"
}

module "vpc" {
  source                                    = "git::https://github.com/chahalvikas2022/terraform-gcp-vpc"
  name                                      = "vpc"
  environment                               = "vikas"
  label_order                               = ["name", "environment"]
  mtu                                       = 1460
  routing_mode                              = "REGIONAL"
  network_enabled                           = true
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  delete_default_routes_on_create           = false
}


#===============================(subnet)=================================

module "subnet" {
  source        = "../.."
  name          = ["subnet-a"]
  environment   = "nonprod"
  region        = "asia-northeast1"
  network       = module.vpc.vpc_id
  ip_cidr_range = ["10.10.1.0/24"]
}
