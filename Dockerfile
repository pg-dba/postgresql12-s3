FROM postgres:12

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-utils lsb-release
RUN apt-get -y install gnupg2 wget iputils-ping dnsutils
RUN apt-get -y install perl postgresql-plperl-12
RUN wget https://github.com/zubkov-andrei/pg_profile/releases/download/0.3.4/pg_profile--0.3.4.tar.gz
RUN tar xzf pg_profile--0.3.4.tar.gz --directory $(pg_config --sharedir)/extension
RUN apt-get -y install gosu
RUN apt-get update
RUN apt-get -y install awscli
#RUN apt-get -y install barman-cli-cloud
RUN apt-get -y install barman-cli

RUN apt-get clean all

# before init - /var/lib/postgresql/data not exists, postgres user not exists
#COPY archive_wal.sh /var/lib/postgresql/data/archive_wal.sh
#RUN chown postgres:postgres /tmp/archive_wal.sh && chmod 700 /tmp/archive_wal.sh
RUN mkdir -p /home/postgres
COPY archive_wal.sh /home/postgres/archive_wal.sh

WORKDIR /var/lib/postgresql
