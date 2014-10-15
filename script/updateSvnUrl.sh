#!/bin/bash - 

: > /tmp/svnrepourl.txt

sqlite3 .svn/wc.db >> /tmp/svnrepourl.txt << EEOOFF
select root from REPOSITORY;
update REPOSITORY set root="$1";
select root from REPOSITORY;
.quit
EEOOFF

repourl=$(cat /tmp/svnrepourl.txt)
echo ${repourl}
