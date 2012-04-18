#!/usr/bin/gawk -f

# http://bazoud.free.fr/post/2008/10/20/maven-in-colour-maven-en-couleur/

($1 == "[ALL]")      { print "\033[1;37m" $0 "\033[0m"; next; }
($1 == "[FATAL]")    { print "\033[1;31m" $0 "\033[0m"; next; }
($1 == "[ERROR]")    { print "\033[1;31m" $0 "\033[0m"; next; }
($1 == "[WARNING]")  { print "\033[1;33m" $0 "\033[0m"; next; }
($1 == "[INFO]")     { print "\033[1;37m" $0 "\033[0m"; next; }
($1 == "[DEBUG]")    { print "\033[1;36m" $0 "\033[0m"; next; }
($1 == "[TRACE]")    { print "\033[1;32m" $0 "\033[0m"; next; }
{ print }
