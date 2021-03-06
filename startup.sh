#!/bin/sh

openssl pkcs12 -export -in /etc/davmailcerts/fullchain.pem -inkey /etc/davmailcerts/privkey.pem -certfile /etc/davmailcerts/fullchain.pem -out $KEYSTOREFILE -password pass:$KEYSTOREPASS
rm /etc/davmailcerts/*.pem
#keytool -genkey -keyalg rsa -keysize 2048 -storepass $KEYSTOREPASS -keystore $KEYSTOREFILE -storetype \
#  pkcs12 -validity 3650 -dname cn=davmail.stir.ac.uk,ou=davmail,o=sf,o=net
sed -i "s|davmail.ssl.keystoreFile=|davmail.ssl.keystoreFile=$KEYSTOREFILE|" /etc/davmail/davmail.properties
sed -i "s/davmail.ssl.keyPass=/davmail.ssl.keyPass=$KEYSTOREPASS/" /etc/davmail/davmail.properties
sed -i "s/davmail.ssl.keystorePass=/davmail.ssl.keystorePass=$KEYSTOREPASS/" /etc/davmail/davmail.properties

/usr/local/davmail/davmail /etc/davmail/davmail.properties &
wait
