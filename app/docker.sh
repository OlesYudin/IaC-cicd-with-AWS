#!/bin/bash

# Login to AWS
sudo aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${account_id}.dkr.ecr.${region}.amazonaws.com

# Build container
docker build -t ${account_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:latest .
docker build -t ${account_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:${image_tag} .

# Push container to AWS
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:latest
docker push ${account_id}.dkr.ecr.${region}.amazonaws.com/${app_name}:${image_tag}