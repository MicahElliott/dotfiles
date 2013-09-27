#!/bin/bash

# .xinitrc — Called by startx
#
# LOTS OF IMPORTANT X SETTINGS NECESSARILY HAPPEN IN ~/.i3/config

export DE=i3

# Disable bell.
xset -b

# Enable more fonts.
xset +fp ~/gitcontainer/projects/orp-font/misc
xset +fp /usr/share/fonts/local

# Seems to have no effect.
###setxkbmap -option grp:switch,grp:shifts_toggle,grp_led:scroll us,eo,it

# For transparentcy see: https://wiki.archlinux.org/index.php/Xcompmgr
# Though that may hog cpu, so not doing for now.
###xcompmgr -c &
###transset-df .8

# To see all the xmodmap mappings: xmodmap -pke

# Swap Caps_Lock and Control_L.
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add    Control = Control_L"

# Swap grave/asciitilde into Alt_R with Escape.
xmodmap -e "remove  grave = grave"
xmodmap -e "remove  asciitilde = asciitilde"
xmodmap -e "remove  Alt = Alt_R"
xmodmap -e "keysym  Alt_R = grave asciitilde"
xmodmap -e "keycode 49 = Escape"
###xmodmap -e "add Alt = grave asciitilde"

# Compose key: Control_R
# http://superuser.com/questions/311612/how-to-get-alt-nnnn-keyboard-shortcuts-to-work-under-linux
#xmodmap -e "keycode 105 = Multi_key"
xmodmap -e "keysym Control_R = Multi_key"

# Other keys worth thinking about switching.
# Use xev to see keycodes/keysyms. On ario:
# KEYSYM      KEYCODE
# grave        49
# asciitilde   49
# Alt_R       108
# Super_L     133
# Menu        135
# Control_L    37

# Clipboard manager. parcellite and clipit both work, but parcellite
# has useful tray icon.
###clipit &
#parcellite &

# XXX: KEYCHAIN WAS HERE

#udiskie &

# these needed to be in .i3/config
#trayer --edge top --align right --SetDockType true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
#nm-applet &
#wicd-client &

# IM client (mem hog)
#gajim &

# Battery monitor. Both batti and batterymon seem to work well.
# batti's icon is more readable in small i3status bar.
###batterymon
#batti &

# CPU frequency. Wish it would do htop. Not sure why load is getting
# high (0.4+), despite gatotray saying quiescent.
#gatotray &

###feh --bg-fill /usr/share/archwall/Arch-Black.png
#feh --bg-fill ~/Pictures/transcat.jpg
# Supposedly nitrogen is better than feh for multiple screens.
###nitrogen --restore &

# https://wiki.archlinux.org/index.php/PulseAudio
# and use `pamixer -- increase 10` (or ponymix)
/usr/bin/start-pulseaudio-x11

###eval $(ssh-agent)
#eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
eval $( gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh )
export GNOME_KEYRING_CONTROL SSH_AUTH_SOCK GPG_AGENT_INFO

# Kill <C-s> terminal pause
# http://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
#stty -ixon

# ConsoleKit needed for some perms, like automount USBs.
# http://igurublog.wordpress.com/downloads/script-devmon/#install
# But now consolekit is deprecated for systemd-loginctl:
# https://wiki.archlinux.org/index.php/ConsoleKit
###source /etc/X11/xinit/xinitrc.d/30-dbus
###exec ck-launch-session dbus-launch i3
exec i3
