# A dockerized aprsc with filtered upstream connection

A dockerized APRSc with "filtered upstream"
This image is based on debian bookworm slim.

## Installation

```shell

cd ~
git glone https://github.com/ploeffler/aprsc-docker
cd aprsc-docker

```

Edit the file config/aprsc.conf to meet your requirements. The most relevant parts are:

```shell
ServerId   NOCALL
PassCode   0
MyAdmin    "My Name, MYCALL"
MyEmail    email@example.com
Uplink "Core filtered" full  tcp  rotate.aprs.net 14580 filter "r/46.0/15.0/1000"
MagicBadness	42.7
```

The magic trick is the following line:

```shell
Uplink "Core filtered" full  tcp  rotate.aprs.net 14580 filter r/46.0/15.0/1000
```

If you are not familiar with the use of server-side filters: please [check this page](https://www.aprs-is.net/javAPRSFilter.aspx)

Be sure to remove the line:

```shell
MagicBadness	42.7
```

CAUTION: The container will fail to run if you dont remove this line frome the config-file.

AFter the needed changes in your configuration, you can start the Docker-container:

```shell
sudo docker build -t aprsc .
sudo docker run --name aprsc --network host -d --restart unless-stopped -v $(pwd)/config:/opt/aprsc/config -dt aprsc '/opt/aprsc/sbin/aprsc' '-c' '/opt/aprsc/config/aprsc.conf' 
```
