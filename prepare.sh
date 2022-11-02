#!/bin/sh
#
# check if docker is running
if ! (docker ps >/dev/null 2>&1)
then
	echo "docker daemon not running, will exit here!"
	exit
fi
echo "Preparing folder init and creating ./.data/init/initdb.sql"
mkdir ./.data/init >/dev/null 2>&1
mkdir -p ./.data/nginx/ssl >/dev/null 2>&1
chmod -R +x ./.data/init
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./.data/init/initdb.sql
echo "done"
echo "Creating SSL certificates"
openssl req -nodes -newkey rsa:2048 -new -x509 -keyout nginx/ssl/self-ssl.key -out nginx/ssl/self.cert -subj '/C=DE/ST=BY/L=Hintertupfing/O=Dorfwirt/OU=Theke/CN=www.createyourown.domain/emailAddress=docker@createyourown.domain'
echo "You can use your own certificates by placing the private key in nginx/ssl/self-ssl.key and the cert in nginx/ssl/self.cert"
echo "done"