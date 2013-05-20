DualPHPonCentos
===============

Bash script to install 2 versions of PHP (5.4 &amp; 5.2) onto a Centos machine. Tested on 5.9

Download and run from /root

You need to manually alter your apache configs with the appropriate handlers:
<Directory "/var/www/html">
AddHandler php5-fastcgi .php
Action php5-fastcgi /cgi-bin/php52-fcgi
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>
<Directory "/var/www/html/php54">
    AddHandler php5-fastcgi .php
    Action php5-fastcgi /cgi-bin/php54-fcgi
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>


