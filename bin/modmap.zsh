#! /usr/bin/env zsh
# modmap — called by .xinitrc to set mappings
# Useful for playing with keyboard layouts and running spontaneously to undo
# bad settings.

# Reset to system standard US layout with:
#   setxkbmap -layout us

# http://en.wikipedia.org/wiki/Compose_key
# Useful ES codes:
# ~n -> ñ
# 'a -> á
# `a -> à
# !! -> ¡ ¿
# Useful EO codes:
# bu -> ŭ
# ^c -> ĉ (ĉĝĥĵŝ
# Useful GR codes:

# Other
# >> -> »
# .. -> …
# .^ -> ·
# -: -> ÷
# |c -> ¢


# RESET!!
setxkbmap -layout us


xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add    Control = Control_L"
xmodmap -e "keycode 66 = Control_L"
#xmodmap -e "keycode 49 = Escape"



# Swap 9( with [{
#xmodmap -e 'keycode 34 = parenleft bracketleft'
#xmodmap -e 'keycode 35 = parenright bracketright'
#xmodmap -e 'keycode 18 = 9 braceleft'
#xmodmap -e 'keycode 19 = 0 braceright'

# Swap () with <>
#xmodmap -e 'keycode 18 = 9 less'
#xmodmap -e 'keycode 19 = 0 greater'
#xmodmap -e 'keycode 59 = comma parenleft'
#xmodmap -e 'keycode 60 = period parenright'

# Swap 9 & 0 with ( & )  (yes, it's crazy)
#xmodmap -e 'keycode 18 = parenleft 9'
#xmodmap -e 'keycode 19 = parenright 0'

# Swap grave/asciitilde into Alt_R with Escape.
#xmodmap -e "remove  grave = grave"
#xmodmap -e "remove  asciitilde = asciitilde"
#xmodmap -e "remove  Alt = Alt_R"
#xmodmap -e "add Alt = grave asciitilde"

# These are no useful now that xscape makes shift an escape
#xmodmap -e "keysym  Alt_R = grave asciitilde"
#xmodmap -e "keycode 108 = grave asciitilde"
#xmodmap -e "keycode 49 = Escape"

# This was a key discovery for removing conflict/delay: use xmodmap to see others
##xmodmap -e 'remove mod1 = grave'
##xmodmap -e 'remove control = Control_L'
#xmodmap -e 'remove mod1 = Alt_R'
#xmodmap -e "add control = Alt_R"

# R_Alt is Ctrl
#xmodmap -e "keycode 108 = Control_L"
#xmodmap -e "keycode 108 = control"
#xmodmap -e "keycode 108 = Control_L"
#xmodmap -e "add Control = 108"

# Hard-to-reach original Ctrl is CapsLock
xmodmap -e "keycode 37 = Caps_Lock"

# "compose"/"multi" key is used for special chars, good for esperanto, etc.
# http://superuser.com/questions/311612/how-to-get-alt-nnnn-keyboard-shortcuts-to-work-under-linux
#xmodmap -e "keycode 105 = Multi_key"
#xmodmap -e "keysym Control_R = Multi_key"
#xmodmap -e "keysym Menu = Multi_key"

# Map apostrophe to Control (shorter reach)
# See example: https://github.com/alols/xcape
# xmodmap -e 'keycode 48 = Hyper_L'
# xmodmap -e 'remove mod4 = Hyper_L'
# xmodmap -e 'add Control = Hyper_L'
# xmodmap -e 'keycode any = apostrophe'
# xmodmap -e 'keysym 0x27 = Hyper_L'
# xmodmap -e 'remove mod4 = Hyper_L'
# xmodmap -e 'add Control = Hyper_L'
# xmodmap -e 'keycode any = apostrophe quotedbl'

#xmodmap -e 'keycode 36 = Hyper_L'
#xmodmap -e 'remove mod4 = Hyper_L'
#xmodmap -e 'add Control = Hyper_L'
#xmodmap -e 'keycode any = semicolon'

# Make semicolon a Control
xmodmap -e 'keycode 47 = Hyper_L'
xmodmap -e 'remove mod4 = Hyper_L'
xmodmap -e 'add Control = Hyper_L'
#xmodmap -e 'keycode any = semicolon'

# Make Return a semicolon/colon
# Something not right here (Return ends up as Hyper_L), but it works!
xmodmap -e 'keycode 36 = Hyper_L'
xmodmap -e 'remove mod4 = Hyper_L'
xmodmap -e 'keycode 36 = semicolon colon'
xmodmap -e 'keycode any = Return'

# Swap ; and :
# http://unix.stackexchange.com/questions/86881/colon-semicolon-remapping-with-xmodmap-with-two-active-setxkbmap-layouts
# xmodmap -e "keycode 47 = colon semicolon"
#xmodmap -e 'keycode 36 = colon semicolon'
# xmodmap -e 'keycode 47 = Control_R'
# xmodmap -e 'keycode 47 = apostrophe quotedbl'

# https://github.com/alols/xcape
pkill xcape  # don't have multiple xcape running!
# xcape -t 180 -e 'Control_L=Return;Shift_L=Escape;Hyper_L=apostrophe'
# xcape -t 180 -e 'Control_L=Return;Shift_L=Escape'
xcape -t 180 -e 'Control_L=Return;Shift_L=Escape;Hyper_L=Return'
# xcape -t 200 -e 'Control_L=Return;Shift_L=Escape;Control_R=apostrophe'
