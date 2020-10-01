#!/bin/bash

set -ex
set -o pipefail

# VARIABLES
CHANNELS=("conda-forge")
PLATFORMS=( $INPUT_PLATFORMS )
#

# TEMP DIR
rm -r temp_build
mkdir temp_build
rm -r conda_build
mkdir conda_build


echo "BUILDING CONDA PACKAGE..."

# to upload packages to conda_recipe
conda config --set anaconda_upload yes

# add channels
for CHANNEL in $CHANNELS
do
	conda config --append channels $CHANNEL
	echo "CONDA CHANNEL ADDED: "$CHANNEL
done

# build the package
conda build --numpy 1.17.3 --output-folder temp_build/ $INPUT_CONDADIR

# convert package for each platforms
find temp_build/ -name *.tar.bz2 | while read file
do
    echo $file
    for PLATFORM in "${PLATFORMS[@]}"
    do
        conda convert --platform $PLATFORM $file  -o conda_build/
    done

done

conda config --set anaconda_upload yes
anaconda login --username $INPUT_CONDAUSERNAME --password $INPUT_CONDAPASSWORD
# to upload packages to conda_recipe but not referenced th package on conda_recipe...
find conda_build/ -name *.tar.bz2 | while read file
do
    echo $file
    anaconda upload $file
done

echo "Building conda package done!"