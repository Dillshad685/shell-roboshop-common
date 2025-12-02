#!/bin/bash

source ./common.sh
app_name=payment

Checks_sudo_user

User_setup
python_install
system_setup


app_restart

print_total_time