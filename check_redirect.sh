#!/bin/bash

DOMAINS_FILE="domains.txt"
OUTPUT_FILE="redirection_output.txt"
DOMAINS=$(cat $DOMAINS_FILE)
for DOMAIN in $DOMAINS; do
	#echo "$DOMAIN"
	REDIRECTION=$(wget --timeout=5 --tries=2 $DOMAIN 2>&1 | grep Location: | tail -n 1 | cut -d ":" -f3 | sed 's/\[following\]//g' | sed 's/\///g')
	if [[ -z "$REDIRECTION" ]]; then
		echo "$DOMAIN ==> KO" >> $OUTPUT_FILE
	else
		echo "$DOMAIN  ==> $REDIRECTION" >> $OUTPUT_FILE
	fi
done
exit 0