FROM debian:11

LABEL maintainer="Israel Martín Escalona"
LABEL version="1.1"
LABEL description="This dockerfile builds a container to run simtools"

RUN apt-get update && apt-get install sudo ssh kmod openssh-client procps wget gnupg apt-transport-https genisoimage libc6-i386 python3-scapy -y && \
    apt-get install apt-utils -y --no-install-recommends && apt-get clean -y

RUN wget -O - http://simtools.upc.edu/simtools/keyFile | apt-key add - && \
    echo "deb http://simtools.upc.edu/simtools /" | tee /etc/apt/sources.list.d/simtools.list

RUN apt-get update && \
    apt-get -f install -y && \
    apt-get update && apt-get clean -y

RUN echo 'deb [trusted=yes] http://www.dit.upm.es/~vnuml/debian binary/' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install vlan xterm bridge-utils screen net-tools -y && apt-get clean -y

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \    
    apt-get install vnuml -y && apt-get clean -y

# Simtools packages
RUN yes yes | DEBIAN_FRONTEND=teletype apt-get install simtools-simctl simtools-kernels simtools-fs-debian5 simtools-fs-debian6 simtools-scenario* simtools-doc-fxt -y && \
    apt-get clean -y

RUN adduser --disabled-password --gecos '' tcgi && \
    adduser tcgi sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    gpasswd -a tcgi vnuml

COPY files/www/www-new.vnuml /usr/share/vnuml/scenarios/
RUN chmod 644 /usr/share/vnuml/scenarios/www-new.vnuml

COPY files/www/debian5.fs /usr/share/vnuml/filesystems/debian5.fs  

USER tcgi
