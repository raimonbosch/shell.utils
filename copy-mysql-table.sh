#!/bin/sh

# The script backups a table and sends it to another mysql server.
# Replace the export by your own use case.

export TABLE=your_table
export DATABASE=your_database

export PROD_HOST=your_production_host
export PROD_USER=your_production_user
export PROD_PASS=your_production_password

export DEV_HOST=your_devel_host
export DEV_USER=your_devel_user
export DEV_PASS=your_devel_password

mysqldump -h $PROD_HOST -u $PROD_USER -p$PROD_PASS $DATABASE $TABLE > /tmp/$TABLE.sql
cat /tmp/$TABLE.sql | mysql -h $DEV_HOST -u $DEV_USER -p$DEV_PASS $DATABASE
