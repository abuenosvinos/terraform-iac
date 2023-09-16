locals {
  whitelist_cidr = ["0.0.0.0/0"]
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "${var.env}-${var.bucket_name}"

  tags = {
    Environment = var.env
    Project     = "Prueba abuenosvinos"
  }
}

#resource "aws_s3_bucket_acl" "example" {
#  bucket = aws_s3_bucket.example_bucket.id
#  acl    = "public-read"
#}

#resource "aws_s3_bucket_public_access_block" "example" {
#  bucket = aws_s3_bucket.example_bucket.id
#
#  block_public_acls       = false
#  block_public_policy     = false
#  ignore_public_acls      = false
#  restrict_public_buckets = false
#}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example_bucket.id
  key    = "hello-world"
  source = "hello-world.html"

  content_type = "text/html"
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.example_bucket.id
  policy = data.aws_iam_policy_document.main.json
}

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*"
    ]
    condition {
      variable = "aws:sourceIp"
      test     = "IpAddress"
      values   = local.whitelist_cidr #Restrict to your IP"
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}