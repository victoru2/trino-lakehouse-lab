variable "project_id" {
  description = "Google Cloud Project Trino"
  default     = "trino-lakehouse"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-east1"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  default     = "trino-lakehouse-gke"
}

variable "node_pool_name" {
  description = "Name of the node pool"
  default     = "default-pool"
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  default     = "e2-standard-2"  # Adjust machine type as per your requirements
}

variable "initial_node_count" {
  description = "Initial number of nodes in the node pool"
  default     = 1  # Adjust as needed
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool"
  default     = 5
}

variable "disk_size_gb" {
  description = "Size of the disk for each node"
  default     = 20  # Adjust disk size as per your requirements
}

variable "disk_type" {
  description = "Type of the disk for each node"
  default     = "pd-standard"  # Adjust disk type as per your requirements
}

variable "min_cpu_platform" {
  description = "Minimum CPU platform for nodes"
  default     = "Intel Skylake"  # Adjust as needed
}

variable "preemptible" {
  description = "Whether nodes are preemptible or not"
  default     = false
}
