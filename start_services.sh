#!/bin/bash

# export env vars to be used by cron
printenv | egrep -v '^[a-z]|GITLAB_OMNIBUS_CONFIG|LS_COLORS|LESSOPEN|LESSCLOSE' |sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh
printf "$GITLAB_OMNIBUS_CONFIG" > GITLAB_OMNIBUS_CONFIG
printf "export GITLAB_OMNIBUS_CONFIG=\"" >> /root/project_env.sh
cat GITLAB_OMNIBUS_CONFIG >> /root/project_env.sh
printf "\"" >> /root/project_env.sh

# start cron
cron
# start gitlab
/assets/wrapper
