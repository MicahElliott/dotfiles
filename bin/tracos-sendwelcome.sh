#! /bin/bash

usage="$0 USER PROJECT REQUESTEREMAIL"
test $# == 3 || { echo $usage; exit 1; }
USER=$1
PROJECT=$2
REQUESTEREMAIL=$3

# Send mail to new USER.
cat >/tmp/welcome.$$ <<EOF
Thank you for your interest in having your project hosted on TracOS!

You now have the following items set up for your project, "$PROJECT":

  * Bash shell account available via ssh:
    $USER@tracos.org

  * Subversion repository:
    http://svn.tracos.org/$PROJECT

  * Personal email account:
    $USER@tracos.org

  * General discussion mailing list:
    $PROJECT@lists.tracos.org

  * Announcement mailing list:
    $PROJECT-announce@lists.tracos.org

  * Trac project homepage:
    http://tracos.org/$PROJECT

Determine your initial password for any of the above by adding "!@#" to your
username. Then please change your account login with the "passwd" command.

Be sure to add your project to the TracOS Live Projects page:
<http://tracos.org/hosting/wiki/LiveProjects>

Please follow the TracOS usage guidelines:
<http://tracos.org/hosting/wiki/UsageGuidelines>

Please add any interesting findings/knowledge to the FAQs page:
<http://tracos.org/hosting/wiki/FAQs>

You might want to post the your new site <http://tracos.org/$PROJECT> to
http://del.icio.us with a tag of "trac-site".

Please confirm that you have received this mail and that you intend to use
this TracOS account to host your project.

-- 
Trac Admin  <><
admin@tracos.org
http://tracos.org
EOF

mutt -c 'admin@tracos.org' -s "Created $PROJECT project on tracos.org" $REQUESTEREMAIL </tmp/welcome.$$
