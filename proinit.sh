#!/bin/bash

set -e

echo "Running project initialization script"

# read -p "What is the project name? " PROJECT_NAME

# # regex explanation:
# # ^                start
# # [a-zA-Z0-9_-]+   letters, numbers, _ or -
# # $                end

# if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then 
#     echo "Error: Project name can only contain letters, numbers, underscores, and hyphens."
#     exit 1
# fi


while true; do
    read -p "Project name: " PROJECT_NAME

    if [[ "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        break
    fi

    echo "Invalid project name. Use only letters, numbers, - and _."
done


read -p "Project description? " PROJECT_DESCRIPTION
read -p "Project author? " PROJECT_AUTHOR

while true; do

    read -p "Project repository URL? in SSH format: " PROJECT_REPOSITORY_URL

    if [[ "$PROJECT_REPOSITORY_URL" =~ ^git@[^:]+:.+\.git$ ]]; then
        break
    fi

    echo "Invalid SSH URL. Example:"
    echo "git@github.com:username/repository.git"

done


while true; do
    read -p "Project location path: " PROJECT_LOCAL_LOCATION_PATH

    if [[ "$PROJECT_LOCAL_LOCATION_PATH" != /* ]]; then
        echo "Please enter an absolute path."
        continue
    fi

    if [[ ! -d "$PROJECT_LOCAL_LOCATION_PATH" ]]; then
        echo "Directory does not exist."
        continue
    fi

    if [[ ! -w "$PROJECT_LOCAL_LOCATION_PATH" ]]; then
        echo "Directory is not writable."
        continue
    fi

    break
done

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
