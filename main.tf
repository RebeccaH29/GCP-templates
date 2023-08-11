provider "google" {
  region      = "us-east1"
}

# [create a custom network for vm]
resource "google_compute_network" "custom" {
  name                    = "test-network"
  auto_create_subnetworks = false
}

#[create a custom subnet for vm]
resource "google_compute_subnetwork" "custom" {
  name          = "test-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = google_compute_network.custom.id
}

resource "google_compute_instance" "single_vm" {
  name         = "single"
  machine_type = "e2-micro"
  zone         = "us-east1"
  network_interface {
    network    = google_compute_network.custom.id
    subnetwork = google_compute_subnetwork.custom.id
  }

  tags = ["test", "dev"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
}
