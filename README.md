# ![](https://gravatar.com/avatar/11d3bc4c3163e3d238d558d5c9d98efe?s=64) aptible/sumologic-example

Example Sumo Logic integration on Docker/Aptible

## Installation and Usage

    git clone https://github.com/aptible/docker-sumologic-example
    cd docker-sumologic-example/
    make run

## Including Within An App On Aptible

To include within an Aptible app, copy the four body lines of the Dockerfile to your own Dockerfile:

    WORKDIR /tmp
    RUN wget https://collectors.sumologic.com/rest/download/deb/64 -O sumo.deb && \
        dpkg -i sumo.deb && rm sumo.deb

    ADD files/etc /etc
    ADD files/bin /usr/local/bin

Then, copy the following files to your own repo:

    files/bin/start-collector
    files/etc/sumo.conf
    files/etc/sumo-sources.conf

Then, set the following `ENV` variables, using `aptible config:set` if on Aptible (or via the `-e` flag when running Docker yourself). You can generate the access ID and access key by following [these instructions](https://service.sumologic.com/help/Generating_Collector_Installation_API_Keys.htm).

| Environment Variable  | Description           |
| --------------------- | --------------------- |
| `SUMOLOGIC_ACCESSID`  | Sumo Logic Access ID  |
| `SUMOLOGIC_ACCESSKEY` | Sumo Logic Access Key |
| `SUMOLOGIC_NAME`      | Helpful Name for Logs |

Finally, modify your Procfile to run the `start-collector` process before your own app. Replace `example-app` with the command you use to start your app:

    web: start-collector && example-app > /var/log/sumologic.log 2>&1

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [Aptible](https://www.aptible.com), [Frank Macreery](https://github.com/fancyremarker), and contributors.
