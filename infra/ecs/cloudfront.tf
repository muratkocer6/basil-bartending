resource "aws_cloudfront_distribution" "frontend_cdn" {
  origin {
    domain_name = "basil-backend-frontend.s3-website-us-east-1.amazonaws.com"
    origin_id   = "s3-basil-backend-frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Basil Bartending Frontend CDN"
  default_root_object = "index.html"

  aliases = ["basilbartending.com", "www.basilbartending.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-basil-backend-frontend"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:182399722085:certificate/049ca33a-4122-4a03-97b0-3ae6052794d2"
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "BasilFrontendCDN"
  }
}
