#! /usr/bin/env python

import urllib, sys

example = 'http%3A%2F%2Ffile6.shutterstock.com%2Fvideos11%2Fvideo_thumb%2F4607%2F276535%2Fshutterstock_v276535.flv'
badurl = sys.argv[1]

sys.stdout.write( urllib.url2pathname(badurl) )
