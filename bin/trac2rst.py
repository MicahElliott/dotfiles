#! /usr/bin/env python

"""Sends a file from trac database to local dir, removing trac-rst junk.
"""

import sys, os

usage="Usage: %s PROJECT FILE"%sys.argv[0]
if len(sys.argv) != 3:
    print usage; sys.exit(1)
project= sys.argv[1]
fname= os.path.splitext(sys.argv[2])[0]

p = os.popen('trac-admin /var/trac/%s wiki export %s'%(project, fname))
# Remove header/footer.
txt = p.readlines()[2:-1]
# Better to print than write here to avoid risk of overwriting.
print ''.join(txt),
#file(fname+'.txt', 'w').write(txt)
