#!/bin/bash

if [[ ! -d /var/lib/postgresql/data ]]; then
exec /docker-entrypoint.sh "$@" &
fi

while [[ ! -d /var/lib/postgresql/data ]]; do sleep 2; done

aws configure --profile ${AWS_PROFILE_MINIO:-minio} set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
aws configure --profile ${AWS_PROFILE_MINIO:-minio} set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
gosu postgres aws configure --profile ${AWS_PROFILE_MINIO:-minio} set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
gosu postgres aws configure --profile ${AWS_PROFILE_MINIO:-minio} set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"

#cat /root/.aws/credentials 
#cat /var/lib/postgresql/.aws/credentials 

if [[ -e /archive_wal.sh ]]; then
   mv /archive_wal.sh /var/lib/postgresql/data/archive_wal.sh
   chown postgres:postgres /var/lib/postgresql/data/archive_wal.sh
   chmod 700 /var/lib/postgresql/data/archive_wal.sh
fi

if [ "$1" = 'postgres' ]; then
    exec gosu postgres "$@"
fi
