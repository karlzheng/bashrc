#!/bin/bash -

# 1. svnadmin create xxx_repo

# 2. conf repo:
#add user and passwd in:
# conf/authz
# conf/passwd

#vi conf/svnserve.conf
# add in [general] :
anon-access = none
auth-access = write
password-db = passwd
authz-db = authz

#3. make it boot with system

#http://blog.chinaunix.net/uid-29158166-id-3983119.html
sudo chmod a+x /etc/init.d/svnd.sh
sudo update-rc.d svnd.sh defaults
