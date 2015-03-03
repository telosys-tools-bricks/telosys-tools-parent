#!/bin/sh

set -e # Stop on error

# PARAMETERS
# $1 : Next Version

# Subdirectories to manage
projects=("telosys-tools-parent" "telosys-tools-commons" "telosys-tools-database" "telosys-tools-generator" "telosys-tools-repository")

# Functions declaration
#########################################
function setNextVersion {
    echo "Set the new version of the project ($1)"
    mvn versions:set -DnewVersion=$1
}

function commitAndPushNextVersion {
    echo "Commit and push the new version of the project ($1)"
    git add pom.xml
    git commit -m "Set the new version $1"
    git push
}


# Procedure
#########################################

# Check arguments
if [ $# -ne 1 ]; then
    echo "ERROR : One argument expected --> Next version (e.q 1.0.1)"
    exit 65
fi

# Base directory
base_dir=`pwd`


# Step 1 : Update parent and child pom files
cd ${base_dir}/../../ # root directory where is the pom parent
setNextVersion $1

# Step 2 : Commit and push the modification for all projects
for project in "${projects[@]}"
do
    cd ${base_dir}/../../../${project}
    current_dir=`pwd`
    echo "************** Process commit and push in ${current_dir} directory **************"
    commitAndPushNextVersion $1
done
