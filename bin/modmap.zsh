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

xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add    Control = Control_L"
xmodmap -e "keycode 66 = Control_L"
xmodmap -e "keycode 49 = Escape"

# Swap ; and :
# http://unix.stackexchange.com/questions/86881/colon-semicolon-remapping-with-xmodmap-with-two-active-setxkbmap-layouts
xmodmap -e "keycode 47 = colon semicolon"

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

xmodmap -e "keysym  Alt_R = grave asciitilde"
xmodmap -e "keycode 108 = grave asciitilde"
xmodmap -e "keycode 49 = Escape"

# This was a key discovery: use xmodmap to see others
xmodmap -e 'remove mod1 = grave'

# "compose"/"multi" key is used for special chars, good for esperanto, etc.
# http://superuser.com/questions/311612/how-to-get-alt-nnnn-keyboard-shortcuts-to-work-under-linux
#xmodmap -e "keycode 105 = Multi_key"
#xmodmap -e "keysym Control_R = Multi_key"
#xmodmap -e "keysym Menu = Multi_key"
