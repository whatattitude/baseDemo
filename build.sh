#!/bin/bash -x

# Check if the Docker buildx plugin is installed and available
if ! docker buildx ls | grep -q buildx; then
  echo "Installing Docker buildx plugin..."
  docker buildx create --use
fi

# Specify the name and version of the Docker image
IMAGE_NAME="hi"
IMAGE_VERSION="linux_amd64"

PRIVATE_RES="119.3.172.171:5000"

# Check the first argument
case $1 in
  build)
    # Build the Docker image for AMD64 architecture
    docker buildx build --platform=linux/amd64 --load -t "$IMAGE_NAME":"$IMAGE_VERSION" .
    echo "Docker image built successfully for AMD64 architecture"
    ;;
  push)
    # Push the Docker image to the registry
    docker tag "$IMAGE_NAME":"$IMAGE_VERSION" "$PRIVATE_RES/$IMAGE_NAME:$IMAGE_VERSION"
    docker push "$PRIVATE_RES/$IMAGE_NAME:$IMAGE_VERSION"
    echo "Docker image pushed successfully to $IMAGE_NAME"
    ;;
  *)
    echo "Invalid argument: Please provide 'build' or 'push'"
    ;;
esac