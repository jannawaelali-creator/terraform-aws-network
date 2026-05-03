terraform {
  backend "s3" {
    bucket = "state-terr-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile= "network"
  }
}
