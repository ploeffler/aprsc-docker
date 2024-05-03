# A dockerized aprsc with filtered upstream connection

A dockerized APRSc with "filtered upstream"
This image is based on debian bookworm slim.

## Installation

```shell

cd ~
git clone https://github.com/ploeffler/aprsc-docker
cd aprsc-docker

```

Edit the file config/aprsc.conf to meet your requirements. The most relevant parts are:

```shell
ServerId   NOCALL
PassCode   0
MyAdmin    "My Name, MYCALL"
MyEmail    email@example.com
Uplink "Core filtered" full  tcp  rotate.aprs.net 14580 filter "r/46.0/15.0/1000 g/OE6PLD*"
MagicBadness	42.7
```

The magic trick is the following line:

```shell
Uplink "Core filtered" full  tcp  rotate.aprs.net 14580 filter "r/46.0/15.0/1000 g/OE6PLD*"
```

If you are not familiar with the use of server-side filters: please [check this page](https://www.aprs-is.net/javAPRSFilter.aspx)

You can add more filters but please keep them inside the quotation marks and seperated by a space - like in the example.

CRITICAL: Be sure to remove the line:

```shell
MagicBadness	42.7
```

CAUTION: The container will fail to run if you don't remove this line frome the config-file.

After the needed changes in your configuration, you can start the Docker-container:

```shell
sudo docker build -t aprsc .
sudo docker run --name aprsc --network host -d --restart unless-stopped -v $(pwd)/config:/opt/aprsc/config -dt aprsc '/opt/aprsc/sbin/aprsc' '-c' '/opt/aprsc/config/aprsc.conf' 
```

## Port description

to acces your personal APRSc you can use the following options (unless you have not changed that in your config, this will describe the default behaviour)

- tcp/14580: this is the well known filterable port aka user specific filters
- tcp/14501: the webinterface with the statistics of your server. accassible via http://yourserver:14501/
- udp/8080:  UDP submit
- tcp:10152: full feed