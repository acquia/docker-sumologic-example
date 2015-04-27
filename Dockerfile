FROM quay.io/aptible/ubuntu:14.04

RUN apt-get update && apt-get -y install wget

WORKDIR /tmp
RUN wget https://collectors.sumologic.com/rest/download/deb/64 -O sumo.deb && \
    dpkg -i sumo.deb && rm sumo.deb

ADD files/etc /etc
ADD files/bin /usr/local/bin

# Include your own app setup instructions here...
# ...

CMD start-collector > /var/log/sumologic.log 2>&1
