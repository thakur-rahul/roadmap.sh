#!/bin/bash

LOGFILE="nginx-access.log"

echo "Top 5 IP addresses with the most requests:"
grep -oE "^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $LOGFILE | sort | uniq -c | sort -nr | head -5 | sed 's/^ *//;s/ / - /'

echo ""
echo "Top 5 most requested paths:"
grep -oE "\"[A-Z]+ ([^ ]+) HTTP" $LOGFILE | cut -d' ' -f2 | sort | uniq -c | sort -nr | head -5 | sed 's/^ *//;s/ / - /'

echo ""
echo "Top 5 response status codes:"
awk '{print $9}' $LOGFILE | sort | uniq -c | sort -nr | head -5 | sed 's/^ *//;s/ / - /'

echo ""
echo "Top 5 user agents:"
cut -d\" -f6 $LOGFILE | sort | uniq -c | sort -nr | head -5 | sed 's/^ *//;s/ / - /'
