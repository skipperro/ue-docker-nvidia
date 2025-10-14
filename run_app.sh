#!/bin/sh

# Get the directory where the script is located
app_dir="/app"

# Search for the first file matching 'Binaries/Win64/*.exe' starting from script_dir
found_file=$(find "$app_dir" -type f -path '*/Binaries/Win64/*.exe' -print -quit)

if [ -n "$found_file" ]; then
    echo "Found executable: $found_file"
    echo "Running wine on $found_file with arguments: $RUN_ARGS"
    sleep 1
    #wine "$found_file" $RUN_ARGS  
    wine /home/ubuntu/nvidia/bin/cudatest.exe
    wine /home/ubuntu/nvidia/bin/nvapi64-tests.exe
    wine /home/ubuntu/nvidia/bin/nvofapi64-tests.exe
    wine /app/ffmpeg/bin/ffmpeg.exe -y -hwaccel cuda -hwaccel_output_format cuda -f lavfi -i testsrc -t 50 -vf hwupload -fps_mode passthrough -c:a copy -c:v h264_nvenc -b:v 1M -f null - 
    wine /app/ffmpeg/bin/ffmpeg.exe -hide_banner -encoders
    wine /app/ffmpeg/bin/ffmpeg.exe -f lavfi -i testsrc2=duration=5:size=1280x720:rate=30 -c:v h264_nvenc -b:v 5M out.mp4
else
    echo "Error: No executable file matching 'Binaries/Win64/*.exe' found."
    exit 1
fi
