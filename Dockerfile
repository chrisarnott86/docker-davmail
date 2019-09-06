FROM openjdk:8-jre-alpine

ARG KEYSTOREPASS=password
ENV INT_KEYSTOREPASS=$KEYSTOREPASS

ARG KEYSTOREFILE=/etc/davmailcerts/davmail.p12
ENV INT_KEYSTOREPASS=$KEYSTOREPASS

MAINTAINER jberrenberg v5.3.1

ADD https://downloads.sourceforge.net/project/davmail/davmail/5.3.1/davmail-5.3.1-3079.zip /tmp/davmail.zip

ADD https://raw.githubusercontent.com/chrisarnott86/docker-davmail/master/davmail.properties /etc/davmail/davmail.properties

RUN adduser davmail -D && \
  mkdir /usr/local/davmail && \
  unzip -q /tmp/davmail.zip -d /usr/local/davmail && \
  rm /tmp/davmail.zip && \
  mkdir /var/log/davmail && \
  chown davmail:davmail /var/log/davmail -R && \
  chown davmail:davmail /etc/davmail/davmail.properties -R && \
  mkdir /etc/davmailcerts && \ 
  keytool -genkey -keyalg rsa -keysize 2048 -storepass ${INT_KEYSTOREPASS} -keystore ${INT_KEYSTOREPASS} -storetype \
  pkcs12 -validity 3650 -dname cn=davmail.stir.ac.uk,ou=davmail,o=sf,o=net && \
  sed -i "s/davmail.ssl.keyPass=/davmail.ssl.keyPass=${INT_KEYSTOREPASS}/" /etc/davmail/davmail.properties && \
  sed -i "s/davmail.ssl.keystorePass=/davmail.ssl.keystorePass=${INT_KEYSTOREPASS}/" /etc/davmail/davmail.properties


EXPOSE        1443
EXPOSE        1993
EXPOSE        1636
EXPOSE        1995
EXPOSE        1465
WORKDIR       /usr/local/davmail

USER davmail

CMD ["/usr/local/davmail/davmail", "/etc/davmail/davmail.properties"]
