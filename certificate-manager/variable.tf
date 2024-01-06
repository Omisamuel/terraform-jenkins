#variable for Certificate Manager
/*variable "domain_name" {}
variable "hosted_zone_id" {}*/

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route 53 hosted zone ID for the domain"
  type        = string
}
