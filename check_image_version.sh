#!/bin/bash

image_name=$1

# Extract the repository and tag from the image name
repo=$(echo "$image_name" | cut -d ':' -f 1)
tag=$(echo "$image_name" | cut -d ':' -f 2)

# Send API request and extract the versions
response=$(curl -s "https://hub.docker.com/v2/repositories/$repo/tags/?page_size=5&page=1&name=$tag")

# Function to extract versions from JSON response
extract_versions() {
    python -c '
import sys
import json

# Parse JSON response
data = json.loads(sys.stdin.read())

# Extract versions from results
versions = [result["name"] for result in data.get("results", [])]

# Print versions
print("\n".join(versions))
'
}

# Check if the specified version exists
version=$(echo "$response" | extract_versions)

if [ $? -eq 0 ]; then
    if echo "$version" | grep -q "^$tag$"; then
        echo 1  # Version exists
    else
        echo 0 # Version does not exist
    fi
else
    echo "Error: Failed to parse API response"
fi
