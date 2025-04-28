provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "react_hosting" {
  bucket = var.bucket_name
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.react_hosting.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "PublicReadGetObject",
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.react_hosting.arn}/*"
      }
    ]
  })
}
