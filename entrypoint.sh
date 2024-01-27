#!/bin/ash

echo ${SSH_KEY} |base64 -d > ~/.ssh/ansible-ci
chmod 600 ~/.ssh/ansible-ci

find /builds -name requirements.yml |xargs sed "s#https://#https://gitlab-ci-token:${CI_JOB_TOKEN}@#g" -i

exec "$@"
