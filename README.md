# postgresql12

https://hub.docker.com/_/postgres

https://github.com/docker-library/docs/blob/master/postgres/README.md

https://www.2ndquadrant.com/en/blog/barman-cloud-part-1-wal-archive/

https://www.2ndquadrant.com/en/blog/barman-cloud-part-2-cloud-backup/

https://www.2ndquadrant.com/en/blog/barman-2-11-barman-cloud-restore-and-barman-cloud-wal-restore/


aws --profile ${AWS_PROFILE_MINIO} --endpoint-url http://u20d1h4:9000 s3 ls backups/$(hostname) --recursive

barman-cloud-backup-list -P ${AWS_PROFILE_MINIO} --endpoint-url http://u20d1h4:9000 s3://backups $(hostname)
