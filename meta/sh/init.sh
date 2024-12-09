#!/bin/sh

# Initializes the development environment

folders=("core talk blogs")

for folder in ${folders[@]}; do
    echo "Initializing $folder"
    cd $folder
    make init
    cd ..
done