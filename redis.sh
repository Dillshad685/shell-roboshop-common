#!/bin/bash

source ./common.sh

Checks_sudo_user


###### redis ########
dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "disable redis"
dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "enable redis"
dnf install redis -y &>>$LOG_FILE
VALIDATE $? "installing redis"


sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOG_FILE
VALIDATE $? "allow all ports"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "enabled redis"
systemctl start redis &>>$LOG_FILE
VALIDATE $? "started redis"

print_total_time