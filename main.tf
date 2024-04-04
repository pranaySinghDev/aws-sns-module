# Define the provider
provider "aws" {
  region = var.region
}

# Create a KMS key for SNS topic encryption
resource "aws_kms_key" "sns_key" {
  description             = "KMS key for SNS topic encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# Define the SNS topic with encryption
resource "aws_sns_topic" "topic" {
  name              = var.topic_name
  kms_master_key_id = aws_kms_key.sns_key.key_id
}

# Define the SNS topic subscription (optional)
resource "aws_sns_topic_subscription" "subscription" {
  count     = var.subscription_endpoint != "" ? 1 : 0
  topic_arn = aws_sns_topic.topic.arn
  protocol  = var.subscription_protocol
  endpoint  = var.subscription_endpoint
}

# Define the module variables
variable "region" {
  description = "AWS region to create resources"
  default     = "us-east-1"
}

variable "topic_name" {
  description = "Name of the SNS topic"
  default     = "my-sns-topic"
}

variable "subscription_endpoint" {
  description = "Endpoint for the SNS topic subscription (email, SMS, etc.)"
  default     = ""
}

variable "subscription_protocol" {
  description = "Protocol for the SNS topic subscription"
  default     = "email"
}

# Define the module outputs
output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.topic.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for SNS topic encryption"
  value       = aws_kms_key.sns_key.arn
}