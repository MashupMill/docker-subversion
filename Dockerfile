FROM ubuntu:14.04
MAINTAINER mashupmill

VOLUME ["/app", "/data"]
EXPOSE 3690
ENV COMPATIBLE_VERSION=\
    ANON_ACCESS=read\
    AUTH_ACCESS=write\
    USERNAME=admin\
    PASSWORD=admin
ADD bootstrap.sh /app/
WORKDIR /app

RUN apt-get install subversion -y && \
    apt-get autoremove -y && \
    apt-get clean

CMD /bin/bash /app/bootstrap.sh
