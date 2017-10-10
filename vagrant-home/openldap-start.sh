#!/bin/bash -e

source args.config

mkdir -p /data/openldap/slapd/database
mkdir -p /data/openldap/slapd/config
chmod -R 777 /data/openldap


if [ -z  "`docker network inspect net_hosting | grep net_hosting`" ]; then 
	docker network create net_hosting
fi


docker run --net net_hosting  --restart=always \
--name openldap-service \
--hostname ldap-service \
--env LDAP_ADMIN_PASSWORD="$LDAP_ADMIN_PASSWORD" \
--volume /data/openldap/slapd/database:/var/lib/ldap \
--volume /data/openldap/slapd/config:/etc/ldap/slapd.d \
--detach osixia/openldap:1.1.8


docker run  --restart=always --net net_hosting --name openldap-phpldapadmin-service --hostname phpldapadmin-service --link openldap-service:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host -p 8081:80  -p 8082:443   --detach osixia/phpldapadmin:0.7.0


PHPLDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" openldap-phpldapadmin-service)

echo "Go to: https://$PHPLDAP_IP"
echo "Login DN: $LDAP_ADMIN_LOGIN"
echo "Password: $LDAP_ADMIN_PASSWORD"



  
  