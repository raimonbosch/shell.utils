
####################
#  Sends your last changes in a git repository to a specified directory
#  Very handy to sync git and svn repositories that are supposed to have the same contents.
####################

#git repo url to clone or take changes from
GIT_REPO=$1

#git-sha with the version from which you want to update
GIT_SHA=$2

#directory where you want to move new/updated files to
DEMIURGE_SVN_PATH=$3

#tmp vars needed for execution
ADDED_FILES=/tmp/added.diff
MODIFIED_FILES=/tmp/modified.diff
DELETED_FILES=/tmp/deleted.diff
DEMIURGE_GIT_PATH=/tmp/demiurge-ascetic/

rm -rf $DEMIURGE_GIT_PATH
git clone $GIT_REPO $DEMIURGE_GIT_PATH
cd $DEMIURGE_GIT_PATH

git diff --name-status $GIT_SHA HEAD | grep -P 'D\t' | perl -pe 's/D\t//g' | sort | uniq > $DELETED_FILES
git diff --name-status $GIT_SHA HEAD | grep -P 'A\t' | perl -pe 's/A\t//g' | sort | uniq > $ADDED_FILES
git diff --name-status $GIT_SHA HEAD | grep -P 'M\t' | perl -pe 's/M\t//g' | sort | uniq > $MODIFIED_FILES

#Remove old files
for file in $(cat $DELETED_FILES)
do
    echo "rm  $DEMIURGE_SVN_PATH$file"
    svn rm $DEMIURGE_SVN_PATH$file
    rm  $DEMIURGE_SVN_PATH$file
done

#Create new directories
for file in $(cat $ADDED_FILES |  perl -pe 's/[^\/]+$/\n/g' | sort | uniq)
do
    echo "mkdir -p $DEMIURGE_SVN_PATH$file"
    mkdir -p $DEMIURGE_SVN_PATH$file
done

#Add new files
for file in $(cat $ADDED_FILES)
do
    echo "cp $DEMIURGE_GIT_PATH$file $DEMIURGE_SVN_PATH$file"
    cp $DEMIURGE_GIT_PATH$file $DEMIURGE_SVN_PATH$file
    svn add $DEMIURGE_SVN_PATH$file
done

#Add modified files
for file in $(cat $MODIFIED_FILES)
do
    echo "cp $DEMIURGE_GIT_PATH$file $DEMIURGE_SVN_PATH$file"
    cp $DEMIURGE_GIT_PATH$file $DEMIURGE_SVN_PATH$file
done
