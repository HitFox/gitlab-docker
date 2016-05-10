#!/bin/bash

###
# This file contains relevant commands to perform a gitlab data restore
###

export BUCKET=git.finleap.com
# download latest s3 backups (config + data)
export LAST_DATA_BACKUP=`aws s3 ls $BUCKET | sort | tail -n 2 | awk '{print $4}' | grep backup`
export LAST_CONFIG_BACKUP=`aws s3 ls $BUCKET | sort | tail -n 2 | awk '{print $4}' | grep config`

# download latest backups from s3
aws s3 cp s3://$BUCKET/$LAST_DATA_BACKUP /var/opt/gitlab/backups/
aws s3 cp s3://$BUCKET/$LAST_CONFIG_BACKUP /tmp

echo "#####"
echo "## !!! Running the following commands will restore gitlab data and overwrite all "
echo "## existing data !! Run them with care."
echo "#####"

echo "tar -xf /tmp/$LAST_CONFIG_BACKUP -C /"

echo "gitlab-ctl reconfigure"

echo "# stop relevant services"
echo "gitlab-ctl stop unicorn"
echo "gitlab-ctl stop sidekiq"

echo "# trigger restore"
echo "gitlab-rake gitlab:backup:restore"

echo "# restart services"
echo "gitlab-ctl start"

echo "# do a check"
echo "gitlab-rake gitlab:check SANITIZE=true"
