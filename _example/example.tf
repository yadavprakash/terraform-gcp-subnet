provider "google" {
  project = "local-concord-408802"
  region  = "us-west1"
  zone    = "asia-northeast1-a"
}

module "vpc" {
  source                                    = "git::git@github.com:opsstation/terraform-gcp-vpc.git?ref=v1.0.0"
  name                                      = "dev"
  environment                               = "test"
  label_order                               = ["name", "environment"]
  routing_mode                              = "REGIONAL"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  delete_default_routes_on_create           = false
}

#===============================(subnet)=================================
module "subnet" {
  source        = "../"
  subnet_names  = ["dev", "ops"]
  environment   = "test"
  gcp_region    = "us-west1"
  network       = module.vpc.vpc_id
  ip_cidr_range = ["10.10.1.0/24", "10.10.5.0/24"]
}