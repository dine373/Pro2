FROM ubuntu:16.04
MAINTAINER Dinesh V
RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN apt-get install -y wget net-tools vim
RUN apt-get install -y default-jre

ADD apache-tomcat-* /opt/
RUN mv /opt/apa* /opt/tomcat
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
EXPOSE 8080

CMD ["/usr/bin/supervisord"]


