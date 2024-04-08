#!/bin/bash

update_version_pattern="Update ([0-9]+\.[0-9]+\.[0-9]+)"
version_pattern="\(version ([0-9].*)\)"
html_content=$(curl -sL https://code.visualstudio.com/updates)

version=$(echo "$html_content" | grep -oE "$update_version_pattern" | awk '{print $2}' | sort -rV | head -n 1)
if [ -z "$version" ]; then
    version=$(echo "$html_content" | grep -oE "$version_pattern" | awk '{gsub(/\(version |\)/, ""); print $0}')
fi
echo "$version"
