FROM debian:12

LABEL maintainer="Israel Martín Escalona"
LABEL version="1.3"
LABEL description="This dockerfile builds a container to run simtools"

RUN apt-get update && apt-get install sudo ssh kmod openssh-client procps wget gnupg apt-transport-https genisoimage \
    libc6-i386 python3-scapy vlan xterm bridge-utils screen net-tools apt-utils nano lsof \
    uml-utilities vlan xterm bridge-utils screen dconf-cli libxml-dom-perl libxml-checker-perl \
    libnetaddr-ip-perl libterm-readkey-perl libnet-pcap-perl libnet-ipv6addr-perl liberror-perl libexception-class-perl \
    xz-utils -y --no-install-recommends && \
    apt-get clean -y

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200

RUN adduser --disabled-password --gecos '' vnuml && \
    adduser --disabled-password --gecos '' tcgi && \
    # adduser tcgi sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    gpasswd -a tcgi vnuml && \
    gpasswd -a tcgi sudo

COPY files/simtools/simtools.tar.xz /simtools.tar.xz
RUN tar xJf /simtools.tar.xz && rm /simtools.tar.xz

USER tcgi
