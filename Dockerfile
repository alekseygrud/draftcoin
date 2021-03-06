
# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*


RUN apt-get -y install build-essential
RUN apt-get -y update
RUN apt-get -y install libssl-dev
RUN apt-get -y update
RUN apt-get -y install libdb++-dev
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install libminiupnpc-dev


WORKDIR /var/www/draftcoin

COPY . ./.
COPY DraftCoin.conf /root/.DraftCoin/DraftCoin.conf

RUN cd src/ && make -f makefile.unix
RUN ./src/DraftCoind -d &> /dev/null &

VOLUME /var/www/activesocial
