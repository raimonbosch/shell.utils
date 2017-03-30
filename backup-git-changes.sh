#!/bin/sh

# The script backups untracked git changes of a working repository 
# and sends'em to a backup file path.

GIT_PATH=$1
BACKUP_PATH=$2

if [ -z "$1" ]
  then
    echo "Help: ./git_backup.sh \${GIT_PATH} \${BACKUP_PATH}"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Help: ./git_backup.sh \${GIT_PATH} \${BACKUP_PATH}"
    exit 1
fi

cd $GIT_PATH && git diff --name-only > /tmp/files_changed.txt
mkdir -p $BACKUP_PATH

for file in `cat /tmp/files_changed.txt`
do
    DIR=$(dirname "$BACKUP_PATH/$file")
    mkdir -p $DIR
    cp $GIT_PATH/$file $BACKUP_PATH/$file
done
