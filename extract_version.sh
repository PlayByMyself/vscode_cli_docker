#!/bin/bash

extract_versions() {
    local pattern="Update ([0-9]+\.[0-9]+\.[0-9]+)"

    # Use grep to extract all version numbers from the HTML content
    grep -oE "$pattern" | awk '{print $2}' | sort -rV
}

# Check if the script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # If the script is executed directly
    if [[ $# -eq 0 ]]; then
        # If no arguments are provided, read from stdin
        if ! tty -s && ! read -t 0; then
            # Read from pipe
            extract_versions | head -n 1
        else
            # Read from Here Document
            if ! [ -t 0 ]; then
                extract_versions | head -n 1
            else
                echo "Usage: ${0##*/} <html_content>"
                echo "Provide the HTML content via Here Document or pipe it to the script."
                exit 1
            fi
        fi
    else
        # Extract versions from the provided HTML content
        echo "$1" | extract_versions | head -n 1
    fi
else
    # If the script is sourced, make the extract_versions function available
    export -f extract_versions
fi
