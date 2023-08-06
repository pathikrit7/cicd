terraform {
  backend "s3" {
    bucket         = "samples3bucketfortf"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dynamodbfortf"
  }
}
