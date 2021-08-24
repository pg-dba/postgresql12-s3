#!/bin/bash
# ARCHIVE=0 не спасает, если есть именованный replication_slots, например, barman
# sudo -iu postgres psql -p 5432 postgres -c "SELECT * FROM pg_replication_slots;"
# sudo -iu postgres psql -p 5432 postgres -c "SELECT pg_drop_replication_slot('barman');"
# sudo -iu postgres PGPORT 5432 psql -p ${PGPORT} postgres -c "DO \$do\$ BEGIN IF EXISTS (SELECT FROM pg_replication_slots where slot_name='barman') THEN PERFORM pg_drop_replication_slot('barman'); END IF; END \$do\$;"
#chown postgres:postgres archive_wal.sh
#chmod 700 archive_wal.sh

# MANAGEMENT
DEBUG=0
LOG=0
ARCHIVE=0

# SETTINGS
PGSERVER=$(hostname)
PDATA='/var/lib/postgresql/data'
LOG_FILE='/tmp/archive_wal-5432.log'
LOG_DBG_FILE='/tmp/archive_wal-5432-debug.log'
#BRSERVER=''

if [[ ${DEBUG} -eq 1 ]]; then
echo "$(date +'[%Y-%m-%d %H:%M:%S]')" >> ${LOG_DBG_FILE}
set -x
exec 2>>${LOG_DBG_FILE}
fi

if [[ ${LOG} -eq 1 ]]; then
echo "$(date +'[%Y-%m-%d %H:%M:%S]') ^ $1 ^ $2 ^ ${AWS_PROFILE_MINIO} ^ ${MINIO_ENDPOINT_URL}" >> ${LOG_FILE}
fi

if [[ ${ARCHIVE} -eq 1 ]];
then
#cd ${PDATA} && rsync -a $1 barman@${BRSERVER}:/var/lib/barman/${PGSERVER}/incoming/$2
##gosu postgres barman-cloud-backup -P ${AWS_PROFILE_MINIO:-minio} -j --immediate-checkpoint -J 4 --endpoint-url ${MINIO_ENDPOINT_URL} s3://backups $(hostname)
##barman-cloud-restore -P minio --endpoint-url http://u20d1h4:9000 s3://backups myappstack-postgres-1 20210714T142930 /data/postgres/
##barman-cloud-wal-archive -P minio -j --endpoint-url http://u20d1h4:9000 s3://backups myappstack-postgres-1 /var/lib/postgresql/data/pg_wal/0000000100000036000000DF
barman-cloud-wal-archive -P ${AWS_PROFILE_MINIO} -j --endpoint-url ${MINIO_ENDPOINT_URL} s3://backups ${PGSERVER} ${PDATA}/${1}
RC=$?
else
RC=0
fi
exit ${RC}
