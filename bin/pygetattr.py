#! /usr/bin/env python

"""Get a module attribute.

Eg, module name or description. Does not import module, but hunts for
module __doc__.
"""

__author__    = 'Micah Elliott <micah.d.elliott at intel.com>'
__version__   = '$Revision: 24 $'
__date__      = '$Date: 2005-08-15 10:04:48 -0700 (Mon, 15 Aug 2005) $'
__credits__   = ''
__copyright__ = 'Copyright (C) 2005 Micah Elliott.'

#-----------------------------------------------------------------------

import sys, re, os

def errUsage():
    print usage
    sys.exit(1)

def errNoMod(modName):
    print>>sys.stderr, 'No module docstring found for "%s".'%modName
    sys.exit(1)

usage  = 'usage: getattr -n|-d|-D MODULE.py'
if len(sys.argv) != 3: errUsage()
attr = sys.argv[1]
modName = sys.argv[2]

# Work with packages, too; assume PACKAGE/__init__.py exists.
if not modName.endswith('.py'):
    if modName.endswith('/'):
        modName = modName[:-1]
    modName = modName+'/__init__.py'

# Formerly imported.
#module = __import__(modName, globals(), locals(), [])
#name  = module.__doc__.split('\n\n')[0]
#descr = '\n\n'.join(module.__doc__.split('\n\n')[1:])

try:            f = file(modName)
except IOError: errNoMod(modName)
src = f.read()
f.close()

mo = re.search(r"(?sm)^('''|\"\"\")(.*?)\1", src)
if not mo: errNoMod()
else:      docstr = mo.group(2)

name = docstr.split('\n\n')[0]
descr = docstr.split('\n\n')[1]
details = '\n\n'.join(docstr.split('\n\n')[2:])

# TODO: could possibly also glean "--version" and "--help" <mde>
if   sys.argv[1] == '-n': print name
elif sys.argv[1] == '-d': print descr,
elif sys.argv[1] == '-D': print details,
else:                     errUsage()
