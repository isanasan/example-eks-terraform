resource "aws_ecr_repository" "web_repository" {
  name                 = "${local.name_prefix}-web-repository"
  image_tag_mutability = "MUTABLE"
 
  force_delete = true
 
  image_scanning_configuration {
    scan_on_push = true
  }
}