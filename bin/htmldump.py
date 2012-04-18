#! /usr/bin/env python

import os, sys, re

#nlRe = re.compile(r'(?m)\n\n+')
#txt = os.popen('w3m -cols 78 -dump %s'%sys.argv[1]).read()
#txt = os.popen('lynx -width=78 -prettysrc -dump %s'%sys.argv[1]).read()
txt = os.popen('elinks -dump-color-mode 1 %s'%sys.argv[1]).read()
print 'dumped with elinks'
print txt
sys.exit(0)
#os.system('cat 

# Trim all lines to true blanks.
txt = re.sub(r'(?m)^\s+$', r'', txt)
print txt
# I'm not quite sure why this works!

'''
sys.exit(0)
print nlRe.findall(txt)
#txt = nlRe.sub(r'\n\n', txt)
txt = nlRe.split(txt)
txt = txt[:10]
#print '\n\n'.join(txt)
print txt
'''
