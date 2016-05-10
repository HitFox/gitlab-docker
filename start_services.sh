#!/bin/bash

# export env vars to be used by cron
printenv | sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh
# start cron
cron
# start gitlab
/assets/wrapper
