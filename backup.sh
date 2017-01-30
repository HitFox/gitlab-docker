#!/bin/bash

# trigger gitlab data backup rake task
gitlab-rake gitlab:backup:create

# trigger gitlab config backup
CONFIG_TAR=$(date +%s)_gitlab_config.tar
tar -cvf $CONFIG_TAR /etc/gitlab/
aws s3 cp $CONFIG_TAR s3://git.finleap.com

# delete config tars older than 7 days
find / -name *gitlab_backup.tar -mtime +7 -type f -delete

# say hello to dead man snitch
curl https://nosnch.in/e8ada076e2
