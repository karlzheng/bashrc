#!/bin/bash - 
#===============================================================================
#
#          FILE:  convert_path.sh
# 
#         USAGE:  ./convert_path.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Anker
#       CREATED: 2024/04/01 14时04分51秒 CST
#      REVISION:  ---
#===============================================================================

# Function to convert Windows path to Linux path
convert_path() {
    local win_path="$1"
    # Replace backslashes with forward slashes
    local intermediate_path=${win_path//\\//}
    # Convert drive letter if present
    if [[ $intermediate_path =~ ^[a-zA-Z]: ]]; then
        local drive_letter=$(echo $intermediate_path | cut -c1 | tr '[:upper:]' '[:lower:]')
        local linux_path="/mnt/$drive_letter${intermediate_path:2}"
    else
        local linux_path=$intermediate_path
    fi
    echo $linux_path
}

# Example usage
read -p "Enter Windows path to convert: " win_path
linux_path=$(convert_path "$win_path")
echo "Linux path: $linux_path"
