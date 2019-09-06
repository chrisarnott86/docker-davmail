FROM openjdk:8-jre-alpine

MAINTAINER jberrenberg v5.3.1

ADD https://downloads.sourceforge.net/project/davmail/davmail/5.3.1/davmail-5.3.1-3079.zip /tmp/davmail.zip

ADD https://raw.githubusercontent.com/chrisarnott86/docker-davmail/master/davmail.properties /etc/davmail/davmail.properties



RUN adduser davmail -D && \
  mkdir /usr/local/davmail && \
  unzip -q /tmp/davmail.zip -d /usr/local/davmail && \
  rm /tmp/davmail.zip && \
  mkdir /var/log/davmail && \
  chown davmail:davmail /var/log/davmail -R && \
  chown -R davmail:davmail /etc/davmail && \
  chown davmail:davmail /etc/davmail/davmail.properties -R && \
  mkdir /etc/davmailcerts


COPY startup.sh /usr/local/davmail/
RUN chmod +x /usr/local/davmail/startup.sh && \
   chown davmail:davmail /usr/local/davmail/startup.sh

EXPOSE        1443
EXPOSE        1993
EXPOSE        1636
EXPOSE        1995
EXPOSE        1465
WORKDIR       /usr/local/davmail

USER davmail

CMD ["/usr/local/davmail/startup.sh"]
