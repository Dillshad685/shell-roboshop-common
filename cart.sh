#!/bin/bash

source ./common.sh
app_name=cart

Checks_sudo_user

nodejs_install
User_setup
system_setup

app_restart

print_total_time