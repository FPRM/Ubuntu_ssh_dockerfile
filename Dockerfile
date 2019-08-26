FROM ubuntu:16.04

MAINTAINER florian pereme <florian.pereme@altran.com>


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
## install package and dependecies for python 3



RUN apt-get update

RUN apt-get install -y openssh-server && debconf && apt-utils && git

RUN mkdir -p /var/run/sshd && \
echo 'root:AZE25&é"' | chpasswd && \
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
CMD /usr/sbin/sshd -D
