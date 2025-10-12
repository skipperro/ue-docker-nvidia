#!/bin/sh

# Build image
echo "Building docker image..."
sleep 1
docker compose build
sleep 1

# Final notes
echo "====================================================================================="
echo "Image is ready!"
echo
echo "Place your Windows Unreal Engine application in ./app directory and run the command:"
echo "sudo sh run.sh"
echo "You can also add extra start parameters for Unreal Engine by passing them to docker:"
echo "sudo sh run.sh -dx11 -Unattended"
echo
echo "As long as there is only one .exe file in Project/Binaries/Win64 directory"
echo "the run_app.sh script will detect it and run automatically."
echo "====================================================================================="
