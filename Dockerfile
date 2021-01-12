FROM debian:latest

MAINTAINER manelgracia

RUN apt-get update

RUN apt-get install sudo ssh kmod openssh-client procps wget gnupg apt-transport-https -y && \
    apt-get install apt-utils -y --no-install-recommends

RUN wget -O - http://simtools.upc.edu/simtools/keyFile | apt-key add - && \
    echo "deb http://simtools.upc.edu/simtools /" | tee /etc/apt/sources.list.d/simtools.list

RUN apt-get install libc6-i386 genisoimage -y && \ 
    wget http://archive.kernel.org/debian-archive/debian/pool/main/c/cdrkit/mkisofs_1.1.9-1_all.deb && \ 
    dpkg -i mkisofs_1.1.9-1_all.deb && \
    rm mkisofs_1.1.9-1_all.deb

RUN apt-get update && \
    apt-get -f install -y && \
    apt-get update

RUN echo 'deb [trusted=yes] http://www.dit.upm.es/~vnuml/debian binary/' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install vlan xterm bridge-utils screen -y

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    apt-get install vnuml -y

RUN yes yes | DEBIAN_FRONTEND=teletype apt-get install simtools-meta-* -y

RUN adduser --disabled-password --gecos '' tcgi && \
    adduser tcgi sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    gpasswd -a tcgi vnuml

COPY www/www-new.vnuml /usr/share/vnuml/scenarios/
RUN chmod 644 /usr/share/vnuml/scenarios/www-new.vnuml

COPY www/debian5.fs /usr/share/vnuml/filesystems/debian5.fs

USER tcgi
