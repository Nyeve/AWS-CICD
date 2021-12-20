#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 756437418345.dkr.ecr.us-east-1.amazonaws.com

echo "Build Steps:"
echo "building image..."
docker build -t 756437418345.dkr.ecr.us-east-1.amazonaws.com .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."
docker push 756437418345.dkr.ecr.us-east-1.amazonaws.com/awscicd:latest

echo "updating AWS ECS service..."
aws ecs update-service --cluster awscicd-cluster --service react-sv --force-new-deployment --no-cli-pager

echo "Done!"
