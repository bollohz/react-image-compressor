
output "ecr_id" {
  value = aws_ecr_repository.react-image-compressor.registry_id
}

output "ecr_registry_url" {
  value = aws_ecr_repository.react-image-compressor.repository_url
}
