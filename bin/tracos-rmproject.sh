usage="$0 PROJECT"
test $# == 1 || { echo $usage; exit 1; }
project=$1

rm -r /var/svn/$project
rm -r /var/trac/$project
/usr/lib/mailman/bin/rmlist $project
/usr/lib/mailman/bin/rmlist $project-announce

echo "You should now manually remove $project info from aliases and httpd.conf"
