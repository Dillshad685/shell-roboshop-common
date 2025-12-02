#!/bin/bash

source ./common.sh
app_name=catalogue
Checks_sudo_user

nodejs_install
User_setup
system_setup

cp $SCRIPT_DIR/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "adding mongodb client" 

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "installed mongodb" 

INDEX=$(mongosh mongodb.dillshad.space --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")
if [ $INDEX -le 0 ]; then
   mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
   VALIDATE $? "Load catalogue products"
else
   echo -e "dbs are present .. $Y SKIPPING $N"
fi

app_restart

print_total_time