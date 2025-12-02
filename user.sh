#!/bin/bash

source ./common.sh
app_name=user

Checks_sudo_user

User_setup
nodejs_install
system_setup

app_restart

print_total_time