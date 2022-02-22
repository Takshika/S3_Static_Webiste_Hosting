terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.3"
    }
  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = "**"
  secret_key = "**"
}

# S3 bucket for website.
resource "aws_s3_bucket" "myawsbucket-taksh" {
  bucket = "myawsbucket-taksh"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

  }

}


#Upload files of your static website
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.myawsbucket-taksh.bucket
  key    = "index.html"
  source = "/Users/tjambhule/Documents/aws/index.html"
  etag = filemd5("/Users/tjambhule/Documents/aws/index.html")
  content_type = "text/html"
}


resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.myawsbucket-taksh.bucket
  key    = "error.html"
  source = "/Users/tjambhule/Documents/aws/error.html"
  etag = filemd5("/Users/tjambhule/Documents/aws/error.html")
  content_type = "text/html"
}