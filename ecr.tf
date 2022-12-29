resource "aws_ecr_repository" "isolates-repo" {
  name = "isolates"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}


