provider "google" {
  project = "gke-kubeflow-425602"
}

module "firefly" {
  source             = "github.com/gofireflyio/terraform-google-firefly-gcp-read-only"
  firefly_access_key = "INFLZPJHSJMUZZNUFSWP"
  firefly_secret_key = "EvPHLJJh6u0PaOeXFJVOSsr6kKsiyDZkCPjye1g4N0Ycfneb0Biut2BMOC9l3KIm"
  name               = "Google Cloud"
  project_id         = "gke-kubeflow-425602"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

#resource "google_storage_bucket" "nitin_bucket" {
#  name          = "nitin_bucket_${random_id.bucket_id.hex}"
#  location      = "US"
#  storage_class = "STANDARD"
#  labels = {
#    name = "int-bucket"
#    team        = "engineering"
#  }
#}

resource "google_storage_bucket" "bucket-name" {
  name          = "bucket_${random_id.bucket_id.hex}"
  location      = "US"
  storage_class = "STANDARD"
  labels = {
    name = "nonprod-bucket"
    team = "engineering"
  }
}
#
#resource "google_storage_bucket" "bucket-3" {
#  name          = "bucket_next_${random_id.bucket_id.hex}"
#  location      = "US"
#  storage_class = "STANDARD"
#  labels = {
#    name = "dev-bucket"
#    team        = "engineering"
#  }
#}
#
#resource "google_storage_bucket" "bucket-4" {
#  name          = "bucket_${random_id.bucket_id.hex}"
#  location      = "US"
#  storage_class = "STANDARD"
#  labels = {
#    name = "prod-bucket"
#    team        = "engineering"
#  }
#}

resource "google_storage_bucket" "state-bucket-firefly" {
  name          = "state_bucket_${random_id.bucket_id.hex}"
  location      = "US"
  storage_class = "STANDARD"
  labels = {
    name = "state-bucket"
    team = "engineering"
  }
}

terraform {
  backend "gcs" {
    bucket = "state_bucket_f1e39f12"
    prefix = "terraform/state"
  }
}
