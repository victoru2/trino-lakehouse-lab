variable "resource_group_location" {
  type        = string
  default     = "centralus"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg-victor-lab"
}

variable "cluster_name" {
  type        = string
  default     = "victor-lab"
}

variable "dns_prefix" {
  type        = string
  default     = "dns-victor-lab"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
}

variable "node_count" {
  type        = number
  default     = 2
}

variable "msi_id" {
  type        = string
  default     = null
}
