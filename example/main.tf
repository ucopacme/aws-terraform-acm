module "acm_certificate" {
  source = "git::https://git@github.com/ucopacme/aws-terraform-acm.git"

  domain_name = "domain.com"
  subject_alternative_names = [
    "domain2.com",
  ]
  zone_id = local.dev_zone_id
}
