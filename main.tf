provider "google" {
  region      = "us-east1"
}

resource "google_compute_instance" "single_vm" {
  name         = "single"
  machine_type = "e2-micro"
  zone         = "us-east1"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
