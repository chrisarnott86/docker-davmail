# DavMail for Docker

[Davmail Gateway](http://davmail.sourceforge.net/) in a Docker container

Davmail Version: 5.3.1

## Quickstart

You need a `davmail.properties` configuration. If you don't know how click [here](http://davmail.sourceforge.net/serversetup.html).

Run the container:

``` bash
DAVMAIL_CONF=<absolute/path/to/davmail.properties>
docker run -v ${DAVMAIL_CONF}:/etc/davmail/davmail.properties jberrenberg/davmail
```

## Exposed ports

The following ports are exposed by the container:

* caldav: 1443
* imap: 1993
* ldap: 1636
* pop: 1995
* smtp: 1465
