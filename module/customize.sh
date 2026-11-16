[ "$API" -lt 29 ] && abort "Android 10+ is required"
for a in $(dumpsys package providers | grep -oE '[A-Za-z0-9_.]+\.grid_control' | sort -u); do
  content update --uri "content://$a/shape" --bind shape_key:s:
done
ui_print "The overlay will activate automatically on boot via OverlayManagerService"
