#!/bin/bash

source ./common.sh

Checks_sudo_user


cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "repo file created"
###### rabbitmq ########
dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "install rabbitmq"
systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "enable rabbitmq-server"
systemctl start rabbitmq-server  &>>$LOG_FILE
VALIDATE $? "start rabbitmq"

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
VALIDATE $? "root pwd set"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
VALIDATE $? "permissions given"


print_total_time