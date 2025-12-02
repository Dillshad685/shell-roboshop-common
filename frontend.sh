#!/bin/bash

source ./common.sh


dnf module disable nginx -y &>>LOG_FILE 
VALIDATE $? "disabled nginx"

dnf module enable nginx:1.24 -y &>>LOG_FILE
VALIDATE $? "enabled nginx"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "installed nginx"

systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "enabled nginx"
systemctl start nginx &>>$LOG_FILE
VALIDATE $? "started nginx" 

rm -rf /usr/share/nginx/html/* 
VALIDATE $? "existing code removed"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
VALIDATE $? "code copied to tmp"

cd /usr/share/nginx/html &>>$LOG_FILE
VALIDATE $? "changed to main folder"

unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "code copied"

rm -rf /etc/nginx/nginx.conf 
cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf &>>$LOG_FILE
VALIDATE $? "code copied to nginx config"

systemctl restart nginx  &>>$LOG_FILE
VALIDATE $? "started nginx" 
