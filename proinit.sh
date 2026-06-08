#!/bin/bash

set -e

echo "Running project initialization script"

read -p "What is the project name? " PROJECT_NAME
read -p "What is the project description? " PROJECT_DESCRIPTION
read -p "Who is the project author? " PROJECT_AUTHOR
read -p "What is the project repository url? in SSH format: " PROJECT_REPOSITORY_URL
read -p "What is the project local location path?  (Absolute path): " PROJECT_LOCAL_LOCATION_PATH

# create the project directory
echo "Creating your project directory....."
PROJECT_DIR="${PROJECT_LOCAL_LOCATION_PATH%/}/${PROJECT_NAME}"
mkdir -p "$PROJECT_DIR"
echo "Project created at ${PROJECT_DIR}"

# create a README.md file with the project name and description
echo "Creating README.md file with project name and description....."
echo "
# $PROJECT_NAME
------------------
$PROJECT_DESCRIPTION


### Author $PROJECT_AUTHOR
" > "$PROJECT_DIR/README.md"
echo "README.md file created with project name and description at ${PROJECT_DIR}/README.md"

# initialize a git repository in the project directory
echo "Initializing git repository in the project directory....."
git -C "$PROJECT_DIR" init
echo "Adding remote origin in the project directory at ${PROJECT_DIR}......"
git -C "$PROJECT_DIR" remote add origin "$PROJECT_REPOSITORY_URL"

# add the README.md file to the git repository
echo "Adding README.md file to the git repository....."
git -C "$PROJECT_DIR" add "./README.md"

echo "Making the initial commit....."
# commit the README.md file to the git repository
git -C "$PROJECT_DIR" commit -m "Initial commit"

echo "Project initialization completed successfully!"
