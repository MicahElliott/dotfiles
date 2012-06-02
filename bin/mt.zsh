#! /bin/zsh

# Toggle touchpad mouse on/off.
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics

synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')
