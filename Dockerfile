FROM israelmartinescalona/simtools:1.3

LABEL maintainer="Israel Martín Escalona"
LABEL version="1.3.1"
LABEL description="This dockerfile builds a container to run simtools"

USER root
COPY files/simtools/fix_802_1q.sh /fix_802_1q.sh
RUN bash /fix_802_1q.sh 66 rm /fix_802_1q.sh

USER tcgi
