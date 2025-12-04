#!/bin/bash

source ./common.sh
app_name=shipping

Checks_sudo_user

User_setup
java_install
system_setup
dnf install mysql -y  &>>$LOG_FILE

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' < /app/db/schema.sql &>>$LOG_FILE
if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOG_FILE
else
    echo"Mysql data is loaded .. $Y SKIPPING $N"

fi

app_restart

print_total_time