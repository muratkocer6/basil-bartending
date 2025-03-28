output "cloudfront_domain" {
  value = aws_cloudfront_distribution.frontend_cdn.domain_name
  description = "CloudFront Distribution Domain Name"
}
