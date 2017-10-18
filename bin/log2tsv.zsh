#! /bin/zsh

# log2tsv — convert ncsa log format to tsv for use with cut
# Reorders line so that datestamp is first, for sortability
# http://serverfault.com/a/214965/295981

# 99.7.166.75 - - [01/Dec/2016:09:38:05 -0800] "GET /login HTTP/1.1" 200 1664 "http://membean.com/" "Mozilla/5.0 (iPad; CPU OS 9_3_5 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13G36 Safari/601.1"

perl -n -e '/^([^ ]+) ([^ ]+) ([^ ]+) (\[[^\]]+\]) "(.*) (.*) (.*)" ([0-9\-]+) ([0-9\-]+) "(.*)" "(.*)"/; print "$4\t$1\t$5\t$6\t$7\t$8\t$9\t$10\t$11\n"' -- $@
