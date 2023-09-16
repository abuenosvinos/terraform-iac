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

#resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#  bucket = aws_s3_bucket.example_bucket.id
#  acl    = "private"
#  #  acl    = "public-read"
#  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
#}
#
#resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
#  bucket = aws_s3_bucket.example_bucket.id
#  rule {
#    object_ownership = "ObjectWriter"
#  }
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