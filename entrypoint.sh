#!/bin/bash

set -ex
set -o pipefail

# VARIABLES
CHANNELS=($INPUT_CHANNELS)
PLATFORMS=($INPUT_PLATFORMS)

# check input parameters
DEFAULT_PLAFORMS=("osx-64 linux-32 linux-64 win-32 win-64")
for PLATFORM in "${PLATFORMS[@]}"
do
  if ! [[ " $DEFAULT_PLAFORMS " =~ .*\ $PLATFORM\ .* ]]; then
      echo $PLATFORM" platform not supported, only one of them: "$DEFAULT_PLAFORMS
      exit 1
  fi
done


# TEMP DIR
mkdir temp_build

##### BUILDING PACKAGE #####
echo ">>>> CONDA PACKAGE BUILDING <<<<"

# add channels
for CHANNEL in "${CHANNELS[@]}"
do
    conda config --append channels $CHANNEL
done

# build the package
conda build --output-folder temp_build/ $INPUT_CONDADIR

# convert package for each platforms
find temp_build/ -name *.tar.bz2 | while read file
do
    echo $file
    for PLATFORM in "${PLATFORMS[@]}"
    do
        conda convert --force --platform $PLATFORM $file  -o temp_build/
    done
done

##### Uploading on Anaconda Cloud #####
echo ">>>> CONDA PACKAGE UPLOADING <<<<"

# to upload packages
conda config --set anaconda_upload yes

# login
anaconda login --username $INPUT_CONDAUSERNAME --password $INPUT_CONDAPASSWORD

# to upload packages
find temp_build/ -name *.tar.bz2 | while read file
do
    echo $file
    anaconda upload $file
done

