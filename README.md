# postgresql12-s3

https://hub.docker.com/_/postgres<BR>
https://github.com/docker-library/docs/blob/master/postgres/README.md<BR>
https://github.com/docker-library/docker<BR>
https://github.com/docker-library/docker/blob/master/19.03/Dockerfile<BR>


https://www.2ndquadrant.com/en/blog/barman-cloud-part-1-wal-archive/<BR>
https://www.2ndquadrant.com/en/blog/barman-cloud-part-2-cloud-backup/<BR>
https://www.2ndquadrant.com/en/blog/barman-2-11-barman-cloud-restore-and-barman-cloud-wal-restore/<BR>


<DIV>
aws --profile ${AWS_PROFILE_MINIO} --endpoint-url http://u20d1h4:9000 s3 ls backups/$(hostname) --recursive<BR>
barman-cloud-backup-list -P ${AWS_PROFILE_MINIO} --endpoint-url http://u20d1h4:9000 s3://backups $(hostname)<BR>
</DIV>


<BR><B>Environment</B><BR>

https://www.postgresql.org/docs/current/app-initdb.html<BR>
https://github.com/docker-library/postgres/blob/cf175692c137b00938f480b3ae1babae0999e05e/12/buster/docker-entrypoint.sh<BR>

<TABLE>
<TR><TD>POSTGRES_PASSWORD</TD><TD>P@ssw0rd</TD></TR>
<TR><TD>POSTGRES_INITDB_ARGS</TD><TD>--data-checksums --encoding=UTF8 --lc-collate='en_US.UTF-8' --lc-ctype='en_US.UTF-8'</TD></TR>
<TR><TD>TZ</TD><TD>Etc/UTC</TD></TR>
<TR><TD></TD><TD></TD></TR>
<TR><TD>AWS_PROFILE_MINIO</TD><TD>minio</TD></TR>
<TR><TD>AWS_ACCESS_KEY_ID</TD><TD>minioadmin</TD></TR>
<TR><TD>AWS_SECRET_ACCESS_KEY</TD><TD>P@ssw0rd</TD></TR>
<TR><TD>MINIO_ENDPOINT_URL</TD><TD>http://u20d1h4:9000</TD></TR>
</TABLE>
