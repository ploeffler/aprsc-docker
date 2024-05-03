FROM debian:bookworm-slim
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install build-essential autoconf make git libevent-dev -y
WORKDIR /temp
RUN git clone https://github.com/ploeffler/aprsc
RUN apt-get clean
RUN cd aprsc/src
WORKDIR /temp/aprsc/src
RUN ./configure
RUN make 
RUN make install
RUN useradd -ms /bin/bash aprscuser
RUN chown -R aprscuser:root /opt/aprsc
WORKDIR /opt/aprsc
