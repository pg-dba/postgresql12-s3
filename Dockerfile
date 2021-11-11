FROM postgres:12

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-utils iputils-ping
RUN apt-get -y install perl postgresql-plperl-12
RUN apt-get -y install gosu
RUN apt-get update
RUN apt-get -y install awscli
#RUN apt-get -y install barman-cli-cloud
RUN apt-get -y install barman-cli

RUN apt-get clean all

COPY archive_wal.sh /var/lib/postgresql/data/archive_wal.sh
RUN chown postgres:postgres /var/lib/postgresql/data/archive_wal.sh && chmod 700 /var/lib/postgresql/data/archive_wal.sh

WORKDIR /var/lib/postgresql
