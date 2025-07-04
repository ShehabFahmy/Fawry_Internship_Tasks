output "id" {
  value = aws_ecr_repository.ecr.id
}

output "ecr-repo-url" {
  value = aws_ecr_repository.ecr.repository_url
}