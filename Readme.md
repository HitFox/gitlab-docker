# Introduction

This image extends the gitlab/gitlab-ce:8.8.4-ce.0 base image by adding functionality to backup gitlab data and its configuration to S3. The backup is triggered by a cron job running in the docker container every 12 hours. `restore.sh` contains relevant commands to restore the data.
