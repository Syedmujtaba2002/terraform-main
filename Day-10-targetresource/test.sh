#!/bin/bash
resources=(
  "aws_s3_bucket.prod"
#   "aws_instance.syed"
)

for resource in "${resources[@]}"; do
  targets+=" -target=$resource"
done

terraform destroy $targets -auto-approve