# acquia/sumologic-example

Example Sumo Logic integration on Docker - using Ubuntu 14.04 from Aptible.

## Installation and Usage

    git clone https://github.com/aptible/docker-sumologic-example
    cd docker-sumologic-example/
    export SUMO_ACCESS_ID=ACCESSIDHERE
    export SUMO_ACCESS_KEY=ACCESSKEYHERE
    make build
    make run

## Pre-build docker file

You can use

````
acquia/aws-syslog
````

This Docker build is hosted in the docker registry (https://registry.hub.docker.com/u/acquia/aws-syslog/). If you want to run this in ECS you need the following configuration. Make sure your Container host has its sumo-sources.json file in the /var/app/current/acquia folder. Make also sure that the environment variables are set.

````
{
  "AWSEBDockerrunVersion": "2",
  "volumes": [
    {
      "name": "sumologic-sources",
      "host": {
        "sourcePath": "/var/app/current/acquia"
      }
    }
  ],
  "containerDefinitions": [
    {
      "name": "sumologic",
      "image": "acquia/aws-syslog",
      "essential": true,
      "memory": 256,
      "portMappings": [
        {
          "hostPort": 25515,
          "containerPort": 514
        }
      ],
      "mountPoints": [
        {
          "sourceVolume": "sumologic-sources",
          "containerPath": "/etc/acquia",
          "readOnly": true
        }
      ]
    }
  ]
}
````


Then, set the following `ENV` variables, you can do this in Elastic Beanstalk or locally via the -e flag when running Docker yourself. You can generate the access ID and access key by following these instructions.. You can generate the access ID and access key by following [these instructions](https://service.sumologic.com/help/Generating_Collector_Installation_API_Keys.htm).

It expects the sumo-sources.json file in /etc/acquia/sumo-sources.json

| Environment Variable  | Description           |
| --------------------- | --------------------- |
| `SUMO_ACCESS_ID`      | Sumo Logic Access ID  |
| `SUMO_ACCESS_KEY`     | Sumo Logic Access Key |

## How to build?

````
git clone git@github.com:acquia/docker-sumologic-example.git
docker build .
# Note the build ID and use it in the following command after -f. -f is to update the latest tag
docker tag -f 2ad2f5b6d0b1 acquia/aws-syslog:latest
docker push acquia/aws-syslog:latest
````

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Derived from Aptible. Customized for [Acquia](www.acquia.com).
Copyright (c) 2014 [Aptible](https://www.aptible.com) and contributors.

