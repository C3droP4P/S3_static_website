resource "aws_s3_bucket" "website" {
  bucket = "cedrop4p.com1"

  tags = {
    Name        = "cedrop4p.com1"
 
  }
}
resource "aws_s3_bucket_website_configuration" "s3_website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = ""
  }

}

resource "aws_s3_bucket_policy" "website-policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy_doc.json
}

data "aws_iam_policy_document" "s3_policy_doc" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.website.arn,
      "${aws_s3_bucket.website.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_policy" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}