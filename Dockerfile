FROM quay.io/aptible/ubuntu:14.04

RUN apt-get update && apt-get -y install wget

WORKDIR /tmp
RUN wget https://collectors.sumologic.com/rest/download/deb/64 -O sumo.deb && \
    dpkg -i sumo.deb && rm sumo.deb

ADD files/etc/sumo.conf /etc/sumo.conf
ADD files/etc/acquia/sumo-sources.json /etc/acquia/sumo-sources.json
ADD files/etc/acquia/sumo-sources.json /etc/sumo-sources.json
ADD files/bin/start-collector /usr/local/bin/start-collector

CMD start-collector
