#!/system/bin/sh
PKG=org.lineageos.overlay.iconshape.meow

until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 1; done

cmd overlay enable "$PKG"
cmd overlay set-priority "$PKG" highest
