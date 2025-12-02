#!/bin/bash

source ./common.sh

Checks_sudo_user()

cp mongodb.repo /etc/yum.repos.d/mongodb.repo 
VALIDATE $? "Adding mongorepo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "INSTALLING mongoDB"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enabling mongoDB"
systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting mongoDB"


sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG_FILE
VALIDATE $? "allowing all ports" #using sed we can insert in the file 

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restarting mongoDB"