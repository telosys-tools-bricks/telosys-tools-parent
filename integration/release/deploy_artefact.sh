#!/bin/sh

function deployArtefact {
    echo "Run mvn deploy to deploy the artefact projects"
    mvn deploy
}
# Procedure
#########################################
# Base directory
base_dir=`pwd`

# Step 1 : Update parent and child pom files
cd ${base_dir}/../../ # root directory where is the pom parent
deployArtefact

