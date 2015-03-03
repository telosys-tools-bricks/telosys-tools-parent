#!/bin/sh

set -e # Stop on error

# PARAMETERS
# $1 : Release version

# Subdirectories to manage
projects=("telosys-tools-parent" "telosys-tools-commons" "telosys-tools-database" "telosys-tools-generator" "telosys-tools-repository")


# Functions declaration
#########################################
function checkIfTagAlreadyExist {
    echo "Check if tag $1 already exist ..."
    if GIT_DIR=./.git git show-ref --tags | egrep -q "refs/tags/$1$"
    then
        echo "ERROR : The tag $1 already exist"
        exit 65
    fi
}

function tagRepo {
    echo "Tag the repository with the version $1"
    git tag $1
}

function pushTagToRemote {
    echo "Push the tag $1 to the remote repository"
    git push origin $1
}

# Procedure
#########################################

# Check arguments
if [ $# -ne 1 ]; then
    echo "ERROR : One argument expected --> Release version (e.q 1.0.1)"
    exit 65
fi

# Base directory
base_dir=`pwd`

# Tag creation for all projects
for project in "${projects[@]}"
do
    cd ${base_dir}/../../../${project}
    current_dir=`pwd`
    echo "************** Process tag creation in ${current_dir} directory **************"

    # Step 1 : Create the tag if doesn't already exist
    checkIfTagAlreadyExist $1

    # Step 2 : Tag the repo
    tagRepo $1

    # Step 3 : Push the tag to the remote repository
    pushTagToRemote $1
done



