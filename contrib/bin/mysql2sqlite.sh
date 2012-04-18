#!/usr/bin/env bash
#
#  A kludge for converting the MYSQL dump provided by http://www.baseball-databank.org/
#  into a SQLITE3 compatible dump
#
#  EXAMPLE USAGE: ./mysql2sqlite.sh BDB-sql-2008-03-28.sql | sqlite3 baseball.db
#
# MDE:
# From:
# http://www.stat.berkeley.edu/~statcur/Workshop2/Assignments/Baseball/instructions.html
#
# Micah's hack below, to support 2009 baseball data.
# 
#  mysql2sqlite.sh
#  vqv

cat $1 |
grep -v 'LOCK' |
grep -v ' KEY ' |
grep -v ' UNIQUE KEY ' |
grep -v ' PRIMARY KEY ' |
grep -v '^SET' |  # HACK: MDE
perl -pe 's/ ENGINE[ ]*=[ ]*[A-Za-z_][A-Za-z_0-9]*(.*DEFAULT)?/ /gi' |
perl -pe 's/ CHARSET[ ]*=[ ]*[A-Za-z_][A-Za-z_0-9]*/ /gi' |
perl -pe 's/ [ ]*AUTO_INCREMENT=[0-9]* / /gi' |
perl -pe 's/ unsigned / /g' |
perl -pe 's/ auto_increment/ primary key autoincrement/gi' |
perl -pe 's/ smallint[(][0-9]*[)] / integer /gi' |
perl -pe 's/ tinyint[(][0-9]*[)] / integer /gi' |
perl -pe 's/ int[(][0-9]*[)] / integer /gi' |
perl -pe 's/ character set [^ ]* / /gi' |
perl -pe 's/ enum[(][^)]*[)] / varchar(255) /gi' |
perl -pe 's/ on update [^,]*//gi' |
perl -e 'local $/;$_=<>;s/,\n\)/\n\)/gs;print "begin;\n";print;print "commit;\n"' |
perl -pe '
if (/^(INSERT.+?)\(/) {
   $a=$1;
   s/\\'\''/'\'\''/g;
   s/\\n/\n/g;
   s/\),\(/\);\n$a\(/g;
}
'
