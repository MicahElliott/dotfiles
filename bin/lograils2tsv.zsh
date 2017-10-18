#! /bin/zsh

# lograils2tsv — convert ncsa log format to tsv for use with cut
# Reorders line so that passengerid and datestamp are first, for sortability
# http://serverfault.com/a/214965/295981

# I, [2016-12-01T09:48:29.353308 #17467]  INFO -- : Processing by StudentsController#view as HTML
perl -n -e '/^I, \[([^ ]+) #([^ ]+)] +([^ ]+) +-- : ( *.*)/; print "$2\t$1\t$3\t$4\n"' -- $@
