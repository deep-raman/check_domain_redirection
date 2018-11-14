#!/bin/bash

DOMAINS_FILE="domains-list.csv"

DOMAINS=$(cat $DOMAINS_FILE)

for DOMAIN in $DOMAINS; do
	NAME=$(echo $DOMAIN | cut -d"," -f1)
	REGISTRAR=$(echo $DOMAIN | cut -d"," -f2)
	LOGIN=$(echo $DOMAIN | cut -d"," -f3)
	QUERY="INSERT INTO skytours.domains (domain_name, registrar, login) values (\"$NAME\", \"$REGISTRAR\", \"$LOGIN\")"
	echo $QUERY
	mysql -e "$QUERY"
done
