#!/bin/bash

setup -e

echo "Running project initialization script"


read -p "What is the project name? " PROJECT_NAME
read -p "What is the project description? " PROJECT_DESCRIPTION
read -p "Who is the project author? " PROJECT_AUTHOR
read -p "What is the project repository url? in SSH format: " PROJECT_REPOSITORY_URL
read -p "What is the project local location path?  (Absolute path): " PROJECT_LOCAL_LOCATION_PATH

# create the project directory
mkdir -p "$PROJECT_LOCAL_LOCATION_PATH"

# create a README.md file with the project name and description
echo "# $PROJECT_NAME" > "$PROJECT_LOCAL_LOCATION_PATH/README.md"
echo "$PROJECT_DESCRIPTION" >> "$PROJECT_LOCAL_LOCATION_PATH/README.md"
echo "\nAuthor: $PROJECT_AUTHOR" >> "$PROJECT_LOCAL_LOCATION_PATH/README.md"

# initialize a git repository in the project directory
git -C "$PROJECT_LOCAL_LOCATION_PATH" init
git -C "$PROJECT_LOCAL_LOCATION_PATH" remote add origin "$PROJECT_REPOSITORY_URL"

# add the README.md file to the git repository
git -C "$PROJECT_LOCAL_LOCATION_PATH" add "./README.md"

# commit the README.md file to the git repository
git -C "$PROJECT_LOCAL_LOCATION_PATH" commit -m "Initial commit"
