#!/bin/bash

. /etc/profile

mongod --dbpath  /usr/local/bin/mongodb-linux-x86_64-${MONGO_VERSION}/data &

while :
do
   netstat -ntlup | grep -w 27017
   [ $? -eq 0 ] && break
done

echo "show dbs;" | mongo --shell | grep -w leanote
[ $? -ne 0 ] && mongorestore -h localhost -d leanote --dir /usr/local/bin/leanote/mongodb_backup/leanote_install_data

bash bin/run.sh
