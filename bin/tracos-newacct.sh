#! /bin/bash

usage="$0 USER PROJECT REQUESTEREMAIL"
test $# == 3 || { echo $usage; exit 1; }
user=$1
project=$2
requesteremail=$3

echo '==> Create new user <=='
grep $user /etc/passwd || {
    useradd -G tracos $user
    echo ${user}'!@#' | passwd --stdin $user
}
mkdir /usr/share/trac/htdocs/$project
chown $user:tracos /usr/share/trac/htdocs/$project

echo '==> Add user to htpasswd file <=='
grep $user /etc/svn-auth-file || {
    htpasswd -m -b /etc/svn-auth-file $user ${user}'!@#'
}

echo '==> Create subversion repository <=='
svnadmin create /var/svn/$project

echo '==> Create trac acct and set permissions <=='
trac-admin /var/trac/$project initenv "$project" 'sqlite:db/trac.db' \
   "/var/svn/$project" /usr/share/trac/templates
trac-admin /var/trac/$project permission add $user TRAC_ADMIN

echo '==> Create mailing lists <=='
cp /etc/aliases /etc/aliases.$$
/usr/lib/mailman/bin/newlist --quiet \
   "$project" "${user}@tracos.org" ${user}'!@#' \
   | tail -11 >> /etc/aliases
/usr/lib/mailman/bin/newlist --quiet \
   "$project-announce" "${user}@tracos.org" ${user}'!@#' \
   | tail -11 >> /etc/aliases

echo '==> Configure mailing lists <=='
echo "description = '$project General Mailing List'"  >foo.txt
echo "info='This list is for users and developers.'" >>foo.txt
/usr/lib/mailman/bin/config_list -i foo.txt "$project"
echo "description = '$project Announcement Mailing List'"     >foo.txt
echo "info='This list is for project update announcements.'" >>foo.txt
/usr/lib/mailman/bin/config_list -i foo.txt "$project-announce"

echo '==> Add user to mailing lists <=='
echo -e "${user}@tracos.org\n$requesteremail" \
   |/usr/lib/mailman/bin/add_members -r - tracos-users
echo -e "${user}@tracos.org\n$requesteremail" \
   |/usr/lib/mailman/bin/add_members -r - "$project"
echo -e "${user}@tracos.org\n$requesteremail" \
   |/usr/lib/mailman/bin/add_members -r - "$project-announce"

service sendmail restart
service mailman  restart

echo '==> Change correct ownership/permissions for all above info <=='
chmod 777 /var/trac/$project/db
chmod 666 /var/trac/$project/db/trac.db
chmod 777 /var/trac/$project/attachments
# FIXME: Might have to chmod other dirs too. <MDE>
chown -R apache:apache /var/svn/$project/
chown -R $user:$user   /var/trac/$project/

echo '==> Manually setup apache to recognize new URL <=='
apacheinfo="
   ScriptAliasMatch ^/$project(.*) \"/var/www/cgi-bin/trac.cgi/\$1\"
   <Location \"/$project\">
       SetEnv TRAC_ENV \"/var/trac/$project/\"
   </Location>
   <Location \"/$project/login\">
       AuthType Basic
       AuthName \"$project trac login\"
       AuthUserFile /etc/svn-auth-file
       Require valid-user
   </Location>
"
echo "Add the following information to /etc/httpd/conf/httpd.conf:"
echo "$apacheinfo"
echo -e "\nthen 'service httpd restart'"

echo '==> Manually send mail notice to requester with welcome.sh script <=='

echo '==> DONE <=='
