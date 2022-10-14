resource "aws_ecr_repository" "ecr" {
    # for_each = toset(var.ecr_name)
    # name = each.key
    name = var.ecr_name
    # image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
#   tags = var.tag
}
