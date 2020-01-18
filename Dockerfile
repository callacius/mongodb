FROM ubuntu:bionic


RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.2.list && \
    apt-get update && \
    apt-get install -y mongodb && \
	apt install mongodb-org && \
	systemctl enable mongodb && \
	systemctl start mongodb
	
RUN mkdir -p /data/db /data/configdb && \
	chown -R mongodb:mongodb /data/db /data/configdb	

VOLUME /data/db /data/configdb

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

EXPOSE 27017 28017

ENTRYPOINT ["set_mongodb_password.sh"]

CMD ["/run.sh"]