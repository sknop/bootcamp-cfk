FROM ubuntu:24.04
LABEL org.opencontainers.image.authors="seknop@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt update &&\
    apt install -y \
        samba \
        smbclient \
        winbind \
        libpam-winbind \
        libnss-winbind \
        ldap-utils \
        openjdk-21-jdk \
        inetutils-ping \
        vim \
        curl

RUN \
   rm /etc/samba/smb.conf

EXPOSE 88
EXPOSE 88/UDP
EXPOSE 123
EXPOSE 123/UDP
EXPOSE 135
EXPOSE 137-138/UDP
EXPOSE 139
EXPOSE 389
EXPOSE 389/UDP
EXPOSE 445
EXPOSE 464
EXPOSE 464/UDP
EXPOSE 636
EXPOSE 1024-1044
EXPOSE 3268-3269

ADD init.sh /init.sh
ADD add_ldifs.sh /add_ldifs.sh
RUN chmod 755 /init.sh /add_ldifs.sh
CMD ["/init.sh"]


