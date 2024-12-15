# Define providers for both regions
provider "aws" {
  alias  = "us_east_1"
  region = var.us_east_1_region
}

provider "aws" {
  alias  = "us_west_1"
  region = var.us_west_1_region
}