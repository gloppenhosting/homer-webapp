FROM centos:centos7
MAINTAINER Andreas Krüger

# Deps from: https://github.com/sipcapture/homer/blob/master/scripts/extra/homer_installer.sh
RUN yum install -y autoconf automake bzip2 cpio curl curl-devel curl-devel \
                   expat-devel fileutils make gcc gcc-c++ gettext-devel gnutls-devel openssl \
                   openssl-devel openssl-devel mod_ssl perl patch unzip wget zip zlib zlib-devel \
                   bison flex mysql mysql-devel pcre-devel libxml2-devel sox httpd php php-gd php-mysql php-json

RUN git clone --depth 1 https://github.com/sipcapture/homer/ /homer

RUN cp -R /homer/webhomer /var/www/html/
RUN chmod -R 0777 /var/www/html/webhomer/tmp
COPY configuration.php /var/www/html/webhomer/configuration.php
COPY preferences.php /var/www/html/webhomer/preferences.php

COPY vhost.conf /etc/httpd/conf.d/000-homer.conf

COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
