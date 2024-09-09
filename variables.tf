variable "domain_name" {
  description = "The primary domain name for the ACM certificate"
  type        = string
}

# Define the variable for region
variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  
}

variable "subject_alternative_names" {
  description = "List of alternative domain names for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "The Route 53 zone ID where DNS validation records should be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
