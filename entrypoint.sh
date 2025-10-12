#!/usr/bin/env bash
set -euo pipefail

# Run selkies supervisor in background
/usr/bin/supervisord &
sleep 5

# Create wineprefix
sh /home/ubuntu/create_wineprefix.sh


# Run our app as PID 1
#exec vkcube
#exec mangohud /app/Garage42.x86_64 ${RUN_ARGS:-} "$@"
# exec pavucontrol ${RUN_ARGS:-} "$@"
exec sh /run_app.sh ${RUN_ARGS:-} 

# Keep container alive tied to Xorg (remove if you exec your app as PID 1)
#wait ${XORG_PID:-} || true

