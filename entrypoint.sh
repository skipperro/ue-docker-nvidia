#!/usr/bin/env bash
set -euo pipefail

# Run selkies supervisor in background
/usr/bin/supervisord &
sleep 5

# Create wineprefix (if not created already)
sh /home/ubuntu/create_wineprefix.sh

# Run our app as PID 1
exec sh /run_app.sh ${RUN_ARGS:-} 


