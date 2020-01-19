FROM ubuntu:bionic

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.2list && \
    apt-get update && \
    apt-get install -y \
	mongodb-org=4.2.2 \
	mongodb-org-server=4.2.2 \
	mongodb-org-shell=4.2.2 \
	mongodb-org-mongos=4.2.2 \
	mongodb-org-tools=4.2.2 

VOLUME /data/db /data/configdb

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

EXPOSE 27017 28017

CMD ["/run.sh"]