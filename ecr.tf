resource "aws_ecr_repository" "my_repository" {
  name = "docker-ecr-repository"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}


