#! /bin/bash
sudo  su
apt install apache2 -y
cat << EOF > /var/www/html/index.html
<html> <body bgcolor="aqua"><h1>Hello World form  $(hostname)</h1>
<p> Welcome to the page!</p>
</body></html>
EOF
#systemctl start httpd