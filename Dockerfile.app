FROM ubuntu:22.04

ENV locale "en_US"
ENV timezone "Etc/UTC"
ENV appname "sql-ledger"
ENV sourcecode "https://github.com/ch1pp3w4/sql-ledger.git"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
apt-get -y install \
acpid \
apache2 \
apg \
build-essential \
git \
libarchive-zip-perl \
libcgi-formbuilder-perl \
libcgi-simple-perl \
libclone-perl \
libconfig-std-perl \
libdate-calc-perl \
libdatetime-perl \
libdbd-pg-perl \
libdbi-perl \
libdbix-simple-perl \
libemail-address-perl \
libemail-mime-perl \
libfcgi-perl \
libfile-copy-recursive-perl \
libgd-dev \
libgd-gd2-perl \
libgd-perl \
libhtml-format-perl \
libhtml-template-perl \
libimage-info-perl \
libjson-perl \
liblist-moreutils-perl \
libmime-lite-perl \
libmime-tools-perl \
libnet-smtp-ssl-perl \
libnet-sslglue-perl \
libnumber-format-perl \
libobject-signature-perl \
libparams-validate-perl \
libpdf-api2-perl \
libpq5 \
librose-db-object-perl \
librose-db-perl \
librose-object-perl \
libsort-naturally-perl \
libstring-shellquote-perl \
libtemplate-perl \
libtemplate-plugin-number-format-perl \
libtext-csv-xs-perl \
libtext-iconv-perl \
libtext-markdown-perl \
liburi-perl \
libuser-simple-perl \
libxml-writer-perl \
libyaml-perl \
lynx \
mailutils \
make \
nano \
openssl \
sed \
ssh \
ssl-cert \
sudo \
supervisor \
texlive \
vim \
locales \
screen \
wget \
--no-install-recommends && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install language-pack-en-base \
  texlive-lang-english \
  --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN locale-gen --purge en_US.UTF-8 && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure --frontend noninteractive locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN git clone ${sourcecode} /var/www/html/sql-ledger

RUN mkdir /var/www/html/sql-ledger/spool

#Load default users
ADD ./app/users /var/www/html/sql-ledger/users/
#Load default Templates
ADD ./app/templates /var/www/html/sql-ledger/templates/

#Change permissions for webserver
RUN chown -hR www-data.www-data /var/www/html/sql-ledger/users /var/www/html/sql-ledger/templates /var/www/html/sql-ledger/css /var/www/html/sql-ledger/spool

ADD ./app/index.html /var/www/html/index.html

RUN echo "AddHandler cgi-script .pl" >> /etc/apache2/apache2.conf && \
  echo "Alias /sql-ledger/ /var/www/html/sql-ledger/" >> /etc/apache2/apache2.conf && \
  echo "<Directory /var/www/html/sql-ledger>" >> /etc/apache2/apache2.conf && \
  echo "Options ExecCGI Includes FollowSymlinks" >> /etc/apache2/apache2.conf && \
  echo "</Directory>" >> /etc/apache2/apache2.conf && \
  echo "<Directory /var/www/html/sql-ledger/users>" >> /etc/apache2/apache2.conf && \
  echo "Order Deny,Allow" >> /etc/apache2/apache2.conf && \
  echo "Deny from All" >> /etc/apache2/apache2.conf && \
  echo "</Directory>" >> /etc/apache2/apache2.conf

# ADD Apache
# Run the rest of the commands as the ``root`` user
USER root

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd

# SET Servername to localhost
RUN echo "ServerName localhost" >> /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
 
RUN chown -R www-data:www-data /var/www && \
  chmod u+rwx,g+rx,o+rx /var/www && \
  find /var/www -type d -exec chmod u+rwx,g+rx,o+rx {} + && \
  find /var/www -type f -exec chmod u+rw,g+rw,o+r {} +

#Perl Modul im Apache laden
RUN a2enmod cgi.load  && \
  a2enmod cgi && \
  a2ensite default-ssl  && \
  service apache2 start && \
  a2enmod ssl && \
  service apache2 restart

RUN apachectl -v

EXPOSE 80
 
# Update the default apache site with the config we created.
ADD ./app/sql-ledger /etc/apache2/sites-available/sql-ledger
RUN cd /etc/apache2/sites-enabled/ && ln -s ../sites-available/sql-ledger 001-sql-ledger

# Scripts
ADD ./app/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD ./app/supervisord-apache2.sh /usr/local/bin/supervisord-apache2.sh
ADD ./app/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

CMD ["/usr/local/bin/start.sh"]

