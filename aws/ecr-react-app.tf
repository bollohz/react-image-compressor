resource "aws_ecr_repository" "react-image-compressor" {
  name = "${var.company}/${local.app_id}"
  tags = merge(local.tags, {

  })
}
