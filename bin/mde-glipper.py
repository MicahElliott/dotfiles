from glipper import *
from gettext import gettext as _

import re

def on_new_item(item):
    #script = 'https://github.com/technomancy/leiningen'
    #term = "/usr/bin/urxvt -e %s %s &" % (script, item)
    try:
        if re.match(r'^https?://github.com/', item):
            os.system("/usr/bin/urxvt -e ~/bin/my-glipper.zsh %s &" % item)
    except:
        pass

def info():
    info = {"Name": _("MDE"),
            "Description": _("Micah's plugin"),
            "Preferences": False}
    return info

