#!/bin/bash

# Check if the script is passed the correct number of arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 <image_name:tag>"
    exit 1
fi

# Get the passed argument as the image name and tag
image="$1"

# Use the docker manifest inspect command to check if the image exists
docker manifest inspect "$image" > /dev/null 2>&1

# Check the return value of the command
if [ $? -eq 0 ]; then
    # The image exists, output 1
    echo 1
else
    # The image does not exist, output 0
    echo 0
fi
