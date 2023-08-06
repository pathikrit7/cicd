data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

module "ecr" {
  source = "./ecr"

  repository_name = "nginx-hello-world"

  repository_read_write_access_arns = ["arn:aws:iam::591309224693:role/terraform"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "any",
          countType     = "imageCountMoreThan",
          countNumber   = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ecr_registry" {
  source = "./ecr"

  repository_name = "registry-dev"

  create_repository = false

  manage_registry_scanning_configuration = true
  registry_scan_type                     = "BASIC"
  registry_scan_rules = [
    {
      scan_frequency = "SCAN_ON_PUSH"
      filter         = "*"
      filter_type    = "WILDCARD"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
