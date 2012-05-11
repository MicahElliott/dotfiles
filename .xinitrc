#!/bin/bash

# .xinitrc — Called by startx
#
# LOTS OF IMPORTANT X SETTINGS NECESSARILY HAPPEN IN ~/.i3/config

# Original stuff from ArchBang
export DE=i3
#exec ck-launch-session dbus-launch openbox-session

# Disable bell.
xset -b

# Enable more fonts.
xset +fp ~/gitcontainer/projects/orp-font/misc
xset +fp /usr/share/fonts/local

# For transparentcy see: https://wiki.archlinux.org/index.php/Xcompmgr
# Though that may hog cpu, so not doing for now.
#xcompmgr -c &
#transset-df .8

# To see all the xmodmap mappings: xmodmap -pke

# Swap Caps_Lock and Control_L.
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

# Swap grave/asciitilde into Alt_R with Escape.
xmodmap -e "remove grave = grave"
xmodmap -e "remove asciitilde = asciitilde"
xmodmap -e "remove Alt = Alt_R"
xmodmap -e "keysym Alt_R = grave asciitilde"
xmodmap -e "keycode 49 = Escape"
#xmodmap -e "add Alt = grave asciitilde"

# Other keys worth thinking about switching.
# Use xev to see keycodes/keysyms. On ario:
# KEYSYM      KEYCODE
# grave        49
# asciitilde   49
# Alt_R       108
# Super_L     133
# Menu        135
# Control_L    37

# Clipboard manager
clipit &

#eval $(ssh-agent)
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

#feh --bg-fill /usr/share/archwall/Arch-Black.png
feh --bg-fill ~/Pictures/transcat.jpg
# Supposedly nitrogen is better than feh for multiple screens.
#nitrogen --restore &

# these needed to be in .i3/config
#udiskie &
#trayer --edge top --align right --SetDockType true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
#nm-applet &

# IM client
gajim &

#exec ck-launch-session dbus-launch xmonad
#exec ck-launch-session xmonad

#exec i3
# ConsoleKit needed for some perms, like automount USBs.
# http://igurublog.wordpress.com/downloads/script-devmon/#install
#source /etc/X11/xinit/xinitrc.d/30-dbus
exec ck-launch-session dbus-launch i3
