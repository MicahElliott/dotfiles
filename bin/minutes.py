#! /usr/bin/env python

# TODO: increment work week.

"""<Canonical Name>
"""

__author__    = 'Micah Elliott <mde AT micah.elliott.name>'
__date__      = '$Date: 2007-05-21 14:51:16 -0700 (Mon, 21 May 2007) $'
__revision__  = '$Revision: 179 $'
__version__   = '0.1'
__credits__   = ''
__copyright__ = 'Copyright (C) 2007 Micah Elliott.  All rights reserved.'

import os, sys, optparse, re

oldFile = file(sys.argv[1])
oldMinutesLines = oldFile.readlines()
#oldMinutes = file(sys.argv[1]).read()

#print 'Removing all (./) (completed) items.'
doneRe    = re.compile(r"\(\./\)")
newMinutes = ''.join([l for l in oldMinutesLines if not doneRe.search(l)])
#print newMinutes

pendingRe = re.compile(r"{[Xo]}")

def prevToNew(mo):
    prevNew = mo.group()
    prev, new = prevNew.split('\n\n')[:2]
    newList = []
    for line in prev.split('\n'):
        #if pendingRe.search(line):
            newList.append(line)
    newList += new.split('\n')[1:]
    #return '\nPrevious:\n' + '\n'.join(newList) + '\n\nNew:\n *\n\n'
    return '\n'.join(newList) + '\n\nNew:\n *\n\n'

#print 'Moving all "New" items to "Previous" section.'
newPrevSectionRe = re.compile(r'(?ms)\nPrevious:.*?\n\nNew:.*?\n\n')
newMinutes = newPrevSectionRe.sub(prevToNew, newMinutes)
print newMinutes
