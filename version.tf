terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/home/vagrant/.aws/config"]
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
  profile                  = "mt-lab-master-mgmt"  #Master account id 5826xxxxxx5
  alias                    = "mt-lab-master"
}

#provider "aws" {
#  shared_config_files      = ["/home/vagrant/.aws/config"]
#  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
#  profile                  = "mt-lab-dev-mgmt"  #Dev account id 7673xxxxxx3
#  alias                    = "mt-lab-dev"
#}
