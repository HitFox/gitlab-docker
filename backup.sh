#!/bin/bash

# trigger gitlab data backup rake task
gitlab-rake gitlab:backup:create

# trigger gitlab config backup
CONFIG_TAR=$(date +%s)_gitlab_config.tar
tar -cvf $CONFIG_TAR /etc/gitlab/
aws s3 cp $CONFIG_TAR s3://git.finleap.com

# delete config tars older than 7 days
find ./*.tar -mtime +7 -type f -delete

# TODO dead man snitch call to check in this worker
