#! /usr/bin/env zsh

# qwerkey — keyboard map; call from `.xinitrc` to set mappings

kbstyle=${1=gearhead}

pkill xcape  # don't have multiple xcape running!

# RESET for clean slate!!
setxkbmap -layout us

# Do bulk of work
# xmodmap $0:h/qwerkey-$kbstyle-center.modmap

# https://github.com/alols/xcape
# xcape -t 350 -e 'Mode_switch=Tab;Shift_L=Escape;Control_R=Return;Control_L=minus;Shift_R=slash;Alt_L=parenleft;Alt_R=parenright;Super_L=bracketleft;Super_R=bracketright'

# Planck/QMK workarounds
# xcape -t 350 -e 'Alt_L=parenleft;Alt_R=parenright;Shift_L=colon'
xcape -t 350 -e 'Alt_L=parenleft;Alt_R=parenright'
# xmodmap -e 'keycode 65 = space minus'

# Map KC_MENU (SunProps from Planck) to Compose (multi-key)
# Not working from .xinitrc??
xmodmap -e 'keycode 138 = Multi_key'
