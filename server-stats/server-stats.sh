#!/bin/bash

# Define colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "===== Server Performance Stats ====="

# OS version
echo -e "\n--- OS Version ---"
lsb_release -d 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2

# Uptime
echo -e "\n--- Uptime ---"
uptime -p

# Load average
echo -e "\n--- Load Average ---"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

# CPU usage
echo -e "\n--- CPU Usage ---"
cpu_usage=$(mpstat | awk '/all/ {print 100 - $12}')
if (( $(echo "$cpu_usage > 80" | bc -l) )); then
    echo -e "CPU Usage: ${RED}${cpu_usage}%${NC}"
elif (( $(echo "$cpu_usage > 50" | bc -l) )); then
    echo -e "CPU Usage: ${YELLOW}${cpu_usage}%${NC}"
else
    echo -e "CPU Usage: ${GREEN}${cpu_usage}%${NC}"
fi

# Memory usage
echo -e "\n--- Memory Usage ---"
free -m | awk -v RED=$RED -v YELLOW=$YELLOW -v GREEN=$GREEN -v NC=$NC '
NR==2 {
    usage=$3*100/$2
    if (usage > 80) color=RED
    else if (usage > 50) color=YELLOW
    else color=GREEN
    printf "Used: %s MB | Free: %s MB | Usage: %s%.2f%%%s\n", $3,$4,color,usage,NC
}'

# Disk usage
echo -e "\n--- Disk Usage ---"
df -h --total | awk -v RED=$RED -v YELLOW=$YELLOW -v GREEN=$GREEN -v NC=$NC '
/total/ {
    gsub("%","",$5)
    usage=$5
    if (usage > 80) color=RED
    else if (usage > 50) color=YELLOW
    else color=GREEN
    printf "Used: %s | Free: %s | Usage: %s%s%%%s\n", $3,$4,color,usage,NC
}'

# Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by memory usage
echo -e "\n--- Top 5 Processes by Memory ---"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Logged in users
echo -e "\n--- Logged In Users ---"
who

# Failed login attempts
echo -e "\n--- Failed Login Attempts ---"
lastb | head -n 10

echo "===================================="
