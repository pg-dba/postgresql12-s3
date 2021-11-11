FROM postgres:12

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install apt-utils lsb-release
RUN apt-get -y install gnupg2 wget iputils-ping
RUN apt-get -y install perl postgresql-plperl-12
RUN wget https://github.com/zubkov-andrei/pg_profile/releases/download/0.3.4/pg_profile--0.3.4.tar.gz
RUN tar xzf pg_profile--0.3.4.tar.gz --directory $(pg_config --sharedir)/extension
RUN apt-get -y install gosu
RUN apt-get update
RUN apt-get -y install awscli
#RUN apt-get -y install barman-cli-cloud
RUN apt-get -y install barman-cli

RUN apt-get clean all

COPY archive_wal.sh /var/lib/postgresql/data/archive_wal.sh
RUN chown postgres:postgres /var/lib/postgresql/data/archive_wal.sh && chmod 700 /var/lib/postgresql/data/archive_wal.sh

WORKDIR /var/lib/postgresql
