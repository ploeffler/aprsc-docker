FROM debian:latest

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get clean

RUN apt-get install build-essential autoconf make git vim libevent-dev -y
WORKDIR /temp
RUN git clone https://github.com/ploeffler/aprsc

RUN cd aprsc/src
WORKDIR /temp/aprsc/src
RUN ./configure
RUN make 
RUN make install
WORKDIR /opt/aprsc
RUN sbin/aprsc -c etc/aprsc.conf