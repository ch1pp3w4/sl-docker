FROM ubuntu:22.04

ENV locale "en_US"
ENV timezone "Etc/UTC"
ENV appname "sql-ledger"
ENV sourcecode "https://github.com/ch1pp3w4/sql-ledger.git"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install \
  apache2 \
  build-essential \
  git \
  libdbd-pg-perl \
  libdbi-perl \
  libfcgi-perl \
  libgd-dev \
  libgd-gd2-perl \
  libgd-perl \
  libpq5 \
  librose-db-object-perl \
  librose-db-perl \
  librose-object-perl \
  nano \
  sed \
  ssh \
  ssl-cert \
  sudo \
  supervisor \
  texlive \
  vim \
  locales \
  wget \
  ca-certificates \
  --no-install-recommends && \
  update-ca-certificates && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Add the ability to generate documents in PDF format
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  apt-get -y install language-pack-en-base \
  texlive-lang-english \
  ghostscript \
  texlive-latex-extra \
  texlive-pstricks \
  --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Add the support locale in UTF-8
RUN locale-gen --purge en_US.UTF-8 && \
  locale-gen en_US.UTF-8 && \
  dpkg-reconfigure --frontend noninteractive locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN git clone ${sourcecode} /var/www/html/sql-ledger

#Set up webserver

ADD ./app/users /var/www/html/sql-ledger/users/
ADD ./app/templates /var/www/html/sql-ledger/templates/

RUN mkdir /var/www/html/sql-ledger/spool && \
  chown -hR www-data.www-data \ 
  /var/www/html/sql-ledger/users \ 
  /var/www/html/sql-ledger/templates \ 
  /var/www/html/sql-ledger/css \
  /var/www/html/sql-ledger/spool && \
  cp /var/www/html/sql-ledger/sql-ledger.conf.default /var/www/html/sql-ledger/sql-ledger.conf

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

USER root

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd && \
  echo "ServerName localhost" >> /etc/apache2/conf-available/servername.conf && \
  a2enconf servername

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
 
RUN chown -R www-data:www-data /var/www && \
  chmod u+rwx,g+rx,o+rx /var/www && \
  find /var/www -type d -exec chmod u+rwx,g+rx,o+rx {} + && \
  find /var/www -type f -exec chmod u+rw,g+rw,o+r {} + && \
  a2enmod cgi.load  && \
  a2enmod cgi && \
  a2ensite default-ssl  && \
  service apache2 start && \
  a2enmod ssl && \
  service apache2 restart && \
  apachectl -v

EXPOSE 80
 
ADD ./app/sql-ledger /etc/apache2/sites-available/sql-ledger
RUN cd /etc/apache2/sites-enabled/ && ln -s ../sites-available/sql-ledger 001-sql-ledger

# Scripts
ADD ./app/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD ./app/supervisord-apache2.sh /usr/local/bin/supervisord-apache2.sh
ADD ./app/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/*.sh

CMD ["/usr/local/bin/start.sh"]

