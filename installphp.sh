#!/bin/bash
###########################################################################
# This script will install 2 versions of PHP onto the same server.        #
# You will need to adjust your apache conf file to reflect the folders    #
# which will server the respective version of PHP. You can even have      #
# 2 folders in the same domain have 2 different versions.                 #
# (C) 2013 Michael Sole - Open Source Lincense - No warranties implied    #
###########################################################################

cd /root

yum install apr-devel apr
yum install httpd-devel
yum install libxml2
yum install libxml2-devel
yum install openssl openssl-devel
yum install curl
yum install curl-devel
yum install libpng-devel
yum install libmcrypt libmcrypt-devel
yum install postgresql-devel
yum libmhash
yum libmhash-devel


#Install PHP 54
mkdir php54
cd php54/
wget http:#us3.php.net/get/php-5.4.15.tar.bz2/from/this/mirror

tar xvf php-5.4.15.tar.bz2

cd php-5.4.15

'./configure' '--prefix=/etc/php54' '--enable-fastcgi' '--with-pgsql' '--enable-ftp' '--with-libxml-dir=/usr/lib' '--with-mhash' '--with-openssl' '--enable-bcmath' '--with-zlib' '--enable-zend-multibyte' '--enable-mbstring' '--with-mcrypt' '--enable-pcntl' '--enable-soap' '--enable-sysvshm' '--enable-shmop' '--with-gd' '--with-curl'

make && make install

#Create php52-fcgi in cgi-bin
echo "#!/bin/sh" > /var/www/cgi-bin/php54-fcgi
echo "PHPRC=/etc/php54/lib/" >> /var/www/cgi-bin/php54-fcgi
echo "export PHPRC" >> /var/www/cgi-bin/php54-fcgi
echo "export PHP_FCGI_MAX_REQUESTS=5000" >> /var/www/cgi-bin/php54-fcgi
echo "export PHP_FCGI_CHILDREN=8" >> /var/www/cgi-bin/php54-fcgi
echo "exec /etc/php54/bin/php-cgi" >> /var/www/cgi-bin/php54-fcgi
chmod +x /var/www/cgi-bin/php54-fcgi
#end

#Install PHP 52
mkdir php52
cd php52
wget http:#museum.php.net/php5/php-5.2.10.tar.bz2
tar xvf php-5.2.10.tar.bz2
cd php-5.2.10

'./configure' '--prefix=/etc/php52' '--enable-fastcgi' '--with-pgsql' '--enable-ftp' '--with-libxml-dir=/usr/lib' '--with-mhash' '--with-mcrypt' '--with-openssl' '--enable-bcmath' '--with-zlib' '--enable-zend-multibyte' '--enable-mbstring' '--with-mcrypt' '--enable-pcntl' '--enable-soap' '--enable-sysvshm' '--enable-shmop' '--with-gd' '--with-curl'

make && make install

#Create php52-fcgi in cgi-bin
echo "#!/bin/sh" > /var/www/cgi-bin/php52-fcgi
echo "PHPRC=/etc/php52/lib/" >> /var/www/cgi-bin/php52-fcgi
echo "export PHPRC" >> /var/www/cgi-bin/php52-fcgi
echo "export PHP_FCGI_MAX_REQUESTS=5000" >> /var/www/cgi-bin/php52-fcgi
echo "export PHP_FCGI_CHILDREN=8" >> /var/www/cgi-bin/php52-fcgi
echo "exec /etc/php52/bin/php-cgi" >> /var/www/cgi-bin/php52-fcgi
chmod +x /var/www/cgi-bin/php52-fcgi
#end

#Install fastcgi
mkdir fastcgi
cd fastcgi
wget http:#www.fastcgi.com/dist/mod_fastcgi-current.tar.gz
tar -xzf mod_fastcgi-current.tar.gz
cd mod_fastcgi-2.4.6/
cp Makefile.AP2 Makefile
make top_dir=/usr/lib64/httpd

#Add directory handlers like this:
#<Directory "/var/www/html">
#AddHandler php5-fastcgi .php
#Action php5-fastcgi /cgi-bin/php52-fcgi
#    Options Indexes FollowSymLinks
#    AllowOverride None
#    Order allow,deny
#    Allow from all
#</Directory>
#<Directory "/var/www/html/php54">
#    AddHandler php5-fastcgi .php
#    Action php5-fastcgi /cgi-bin/php54-fcgi
#    Options Indexes FollowSymLinks
#    AllowOverride None
#    Order allow,deny
#    Allow from all
#</Directory>

