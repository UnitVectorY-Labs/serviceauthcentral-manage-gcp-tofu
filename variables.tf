variable "name" {
  description = "The name of the application"
  type        = string
  default     = "serviceauthcentral"
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "regions" {
  description = "List of regions where resources will be created"
  type        = list(string)
}

variable "region_db_names" {
  description = "Map of regions to their respective database names"
  type        = map(string)
}

variable "sac_issuer" {
  description = "The SAC_ISSUER envirionment variable specifying the issuer"
  type        = string
}

variable "sac_cors_origins" {
  description = "The SAC_CORS_ORIGINS envirionment variable specifying the allowed origins"
  type        = string
}
