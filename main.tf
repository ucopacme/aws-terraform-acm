# Define the AWS provider for the us-east-1 region
provider "aws" {
  alias  = "primary"
  region = var.aws_region
}

# Create an ACM certificate in the us-east-1 region
resource "aws_acm_certificate" "this" {
  provider                = aws.primary
  domain_name             = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method       = "DNS"
  tags                    = var.tags

  # Ensure the certificate is created before the old one is destroyed
  lifecycle {
    create_before_destroy = true
  }
}

# Create DNS validation records in Route 53 for the ACM certificate
resource "aws_route53_record" "this" {
  # Iterate over each domain validation option for the ACM certificate
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  # Allow overwriting existing records
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = var.zone_id
  ttl             = 60
}
