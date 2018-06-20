#!/bin/bash

DOMAINS_FILE="domains.txt"
TMP_FILE="/tmp/domain_info"
OUTPUT_FILE="redirection_output.txt"
DOMAINS=$(cat $DOMAINS_FILE)

get_dns() {
	DNS_INFO=$(dig "$DOMAIN" NS | awk '/ANSWER SECTION/{flag=1;next}/Query time:/{flag=0}flag' | grep NS | head -1)
	if [[ -z "$DNS_INFO" ]]; then
		DNS="NO DNS"
	else
		DNS=$(echo "$DNS_INFO" | awk '{print $5}')
	fi
}

for DOMAIN in $DOMAINS; do
	get_dns
	DOMAIN_INFO=$(wget --timeout=5 --tries=2 "$DOMAIN" > "$TMP_FILE" 2>&1)
	REDIRECTION=$(cat $TMP_FILE | grep Location: | tail -n 1 | cut -d ":" -f3 | sed 's/\[following\]//g' | sed 's/\///g')
	HAS_200=$(cat $TMP_FILE | grep '200 OK' | wc -l)

	if [[ -z "$REDIRECTION" ]]; then
       	if [[ "$HAS_200" -eq 1 ]]; then
			IP=$(cat $TMP_FILE | grep connected | cut -d "|" -f2)
			echo "$DOMAIN : $IP : $DNS" >> $OUTPUT_FILE
		else
			echo "$DOMAIN : KO : $DNS">> $OUTPUT_FILE
		fi
	else
		echo "$DOMAIN : $REDIRECTION : $DNS" >> $OUTPUT_FILE
	fi
	/bin/rm -f $TMP_FILE
	/bin/rm -f index.html*
done
exit 0