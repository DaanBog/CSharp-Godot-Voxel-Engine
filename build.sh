#!/usr/bin/env bash

# Parameters

GODOT_VERSION="4.5"
VOXEL_VERSION="master"

GODOT_DIR="godot"
GODOT_REPO="git@github.com:godotengine/godot.git"
GODOT_MODULE_DIR="modules"
VOXEL_DIR="voxel" # directory in the Godot module directory to place Zylann's in
VOXEL_REPO="git@github.com:Zylann/godot_voxel.git"


BUILD_PLATFORM="linuxbsd"

# # Installing dependencies
# echo "installing git"
# sudo apt update
# sudo apt install -y git

# echo "Installing .NET SDK..."
# sudo apt-get install -y dotnet-sdk-8.0

# echo "Installing c++ dependencies"
# sudo apt install -y build-essential scons python3

# Setting up local NuGet source
if [ ! -d "cool_local_nuget_source" ]; then
    echo "Adding local NuGet source"
    mkdir cool_local_nuget_source
    dotnet nuget add source cool_local_nuget_source --name cool_local_nuget_source
else
    echo "Already have local NuGet source, skipping..."
fi
 
# Getting Godot source code
if [ ! -d "$GODOT_DIR" ]; then
    echo "Godot not found, cloning repo"
    git clone "$GODOT_REPO" "$GODOT_DIR"
    cd "$GODOT_DIR"
else
    echo "Godot already exists in directory $GODOT_DIR"
    cd "$GODOT_DIR"
    git pull
fi

# # Set version
# git checkout "$GODOT_VERSION"
# git pull

# # Going into modules
# cd "$GODOT_MODULE_DIR"

# # Getting voxel module source code
# if [ ! -d "$VOXEL_DIR" ]; then
#     echo "Voxel tools not found, cloning repo into $VOXEL_DIR"
#     git clone "$VOXEL_REPO" "$VOXEL_DIR"
#     cd "$VOXEL_DIR"
# else
#     echo "Voxel tools already exists, updating.."
#     cd "$VOXEL_DIR"
#     git pull
# fi

# # Set voxel version
# git checkout "$VOXEL_VERSION"
# git pull

# # Go back to the Godot directory
# cd .. 
# cd ..

# # Building Godot
# scons -j$(nproc) platform=linuxbsd mono_glue=no module_mono_enabled=yes
# bin/godot.linuxbsd.editor.x86_64.mono --headless --generate-mono-glue modules/mono/glue
# scons -j$(nproc) platform=linuxbsd module_mono_enabled=yes
./modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --push-nupkgs-local cool_local_nuget_source