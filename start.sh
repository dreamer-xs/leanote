#!/bin/bash

#init mongodb
. /etc/profile
mongod --dbpath  /usr/local/bin/leanote/db_data &

#loop until db start
while :
do
   netstat -ntlup | grep -w 27017
   [ $? -eq 0 ] && break
done

#check database, and restore databse
echo "show dbs;" | mongo --shell | grep -w leanote
if [ $? -ne 0 ] 
then
    tar xf leanote-linux-amd64-v${LEANOTE_VERSION}.bin.tar.gz
    sed -i "s#app.secret.*#app.secret=${APP_SECRET}#g" /usr/local/bin/leanote/conf/app.conf
    mongorestore -h localhost -d leanote --dir /usr/local/bin/leanote/mongodb_backup/leanote_install_data

fi
#startup leanote
bash leanote/bin/run.sh
