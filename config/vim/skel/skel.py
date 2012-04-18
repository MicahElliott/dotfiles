#! /usr/bin/env python

"""<Canonical Name>

<Description>
"""

### Boilerplate used by pydoc.
__author__    = 'Micah Elliott <mde AT MicahElliott DOT com>'
__version__   = '0.1'
__credits__   = ''
__copyright__ = 'Copyright (C) 2011 Micah Elliott.  All rights reserved.'
__docformat__ = 'restructuredtext en'

### -------------------------------------------------------------------

import os, sys, optparse

# DELETE TO BOTTOM IF NOT STANDALONE SCRIPT.

descr  = '\n\n'.join(__doc__.split('\n\n')[1:])
usage  = 'usage: %prog [OPTIONS] FILE'
banner = 'tool (toolutils) %s\nWritten by %s.'%(__version__, __author__) \
         + '\n\n'+__copyright__
bugs   = 'Report bugs to %s.'%__author__
examples = """
Examples:
  tool -f  # do f
"""

def setUpCmdln():
    cmdln = optparse.OptionParser(usage=usage, version=banner,
                                   description=descr)
    cmdln.add_option('--xxx', action='store_true', help='Do an XXX')
    return cmdln.parse_args()

if __name__ == '__main__':
    OPTS, ARGS = setUpCmdln()
