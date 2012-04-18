#! /usr/bin/env python

"""Sends a file from local dir to trac database, adding trac-rst junk.
Munges filename to be appropriate for trac. Eg, README.txt => Readme
"""

import sys, os, tempfile

usage = "Usage: %s PROJECT FILE"%sys.argv[0]
if len(sys.argv) != 3:
    print usage; sys.exit(1)
project = sys.argv[1]
ifname = sys.argv[2] # README.txt
ofname = os.path.splitext(ifname.capitalize())[0] # Readme
tmpfile = tempfile.mktemp()
print 'Will write', ofname

# Add header/footer.
f = file(tmpfile, 'w')
f.write('{{{\n#!rst\n')
f.write(file(ifname).read())
f.write('}}}')
f.close()

#print file(tmpfile).read()

os.system('trac-admin /var/trac/%(project)s wiki import %(ofname)s %(tmpfile)s'
          % globals())

os.remove(tmpfile)
