# Get the latest Amazon Linux 2023 AMI
data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


# Create S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "DemoS3Bucket"
    Environment = "Dev"
  }
}


# Create EC2 instance
resource "aws_instance" "demo_ec2" {
  ami           = data.aws_ssm_parameter.amazon_linux.value
  instance_type = var.ec2_instance_type

  tags = {
    Name        = "DemoEC2Instance"
    Environment = "Dev"
  }
}
