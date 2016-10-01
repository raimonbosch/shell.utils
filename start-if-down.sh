#!/bin/bash

#To add this check in the crontab, do:
#crontab -e
#Add this line at the end of the cron: * * * * * /home/ubuntu/check-if-up.sh
#:w!

service slam-em-pm-integrator start_ifdown
