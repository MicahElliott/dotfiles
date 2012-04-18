#! /usr/bin/env python

"""
Convert hex codes into RGB suitable for import into GIMP.

http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/266466

Q: Make a website to do this?
"""

import os, sys

'''
if len(sys.argv) != 1:
    print 'one arg required'
    sys.exit(1)

print sys.argv[0]
'''

lines = sys.stdin.readlines()
#print 'inp:', inp

outname = 'hex2rgb.gpl'
out = file(outname, 'w')

def HTMLColorToRGB(colorstring):
    """ convert #RRGGBB to an (R, G, B) tuple """
    colorstring = colorstring.strip()
    if colorstring[0] == '#': colorstring = colorstring[1:]
    if len(colorstring) != 6:
        raise ValueError, "input #%s is not in #RRGGBB format" % colorstring
    r, g, b = colorstring[:2], colorstring[2:4], colorstring[4:]
    r, g, b = [int(n, 16) for n in (r, g, b)]
    return (str(r), str(g), str(b))

out.write('GIMP Palette\n')
for l in lines:
    # (1, 15, 2)
    res = ' '.join(HTMLColorToRGB(l))
    #print res
    out.write(res + '\n')

out.close()
print 'wrote', outname

