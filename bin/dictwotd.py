#! /usr/bin/env python

"""
Dictionary.com Word Of The Day (DictionaryWOTD)

...
"""

import sys, os, re, twitter

# Read in procmail's HTML input from stdin.
mailraw = sys.stdin.read()
tmpfilename = '/home/mde/tmp/dictwotd/dictwotd.txt'

#log = file('/home/mde/tmp/howyafeelin/howyafeelin.log', 'w')
#print>>log, mailraw
#log.close()

# Remove the mail headers.
msgheaders = mailraw.split('\n\n')[0]
msgheaderslist = msgheaders.split('\n')
for h in msgheaderslist:
    if h.startswith('Subject: '):
        subject = h[9:]
        follower = subject.split()[0]
        break
else:
    print 'No Subject header found'
    sys.exit(1)

msgbody = '\n\n'.join(mailraw.split('\n\n')[1:])
msgbody = mailraw

# Use the twitter API to auto-follow.
api = twitter.Api('DictionaryWOTD', 'mdelliot')
twitfollower = api.CreateFriendship(follower)

# Put the pieces together.
res = subject + '\n\n' + msgbody

# Write the result to a tempfile.
outfile = file(tmpfilename, 'w')
outfile.write(res)
outfile.close()
