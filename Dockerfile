FROM mongo:4.2.2-bionic

RUN apt-get update

VOLUME /data/db /data/configdb

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

ENTRYPOINT ["sh", "set_mongodb_password.sh"]

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh

RUN sh /usr/local/bin/docker-entrypoint.sh


EXPOSE 27017 28017

CMD ["/run.sh"]