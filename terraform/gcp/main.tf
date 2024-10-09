provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  deletion_protection = false

  node_pool {
    name       = var.node_pool_name
    initial_node_count = var.initial_node_count

    node_config {
      preemptible  = var.preemptible
      machine_type = var.machine_type
      disk_size_gb = var.disk_size_gb
      disk_type    = var.disk_type
    }

    autoscaling {
      min_node_count = var.initial_node_count
      max_node_count = var.max_node_count
    }

  }
}
