FROM openjdk:8-jre-alpine

MAINTAINER jberrenberg v5.3.1

ADD https://downloads.sourceforge.net/project/davmail/davmail/5.3.1/davmail-5.3.1-3079.zip /tmp/davmail.zip

RUN adduser davmail -D && \
  mkdir /usr/local/davmail && \
  unzip -q /tmp/davmail.zip -d /usr/local/davmail && \
  rm /tmp/davmail.zip && \
  mkdir /var/log/davmail && \
  chown davmail:davmail /var/log/davmail -R && \
  mkdir /etc/davmailcerts && \ 
  keytool -genkey -keyalg rsa -keysize 2048 -storepass password -keystore /etc/davmailcerts/davmail.p12 -storetype \
  pkcs12 -validity 3650 -dname cn=davmail.stir.ac.uk,ou=davmail,o=sf,o=net

VOLUME        /etc/davmail

EXPOSE        443
EXPOSE        993
EXPOSE        636
EXPOSE        995
EXPOSE        465
WORKDIR       /usr/local/davmail

USER davmail

CMD ["/usr/local/davmail/davmail", "/etc/davmail/davmail.properties"]
