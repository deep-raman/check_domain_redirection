#!/bin/bash

DOMAINS_FILE="redirection_output.txt"

DOMAINS=$(cat $DOMAINS_FILE)

for DOMAIN in $DOMAINS; do
	NAME=$(echo $DOMAIN | cut -d";" -f1)
	STATUS=$(echo $DOMAIN | cut -d";" -f2)
	DNS=$(echo $DOMAIN | cut -d";" -f3)
	QUERY="UPDATE skytours.domains set status=\"$STATUS\", dns=\"$DNS\" where domain_name=\"$DOMAIN\";"
	echo $QUERY
	mysql -e "$QUERY"
done
