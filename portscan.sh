#!/bin/bash

# Check for correct usage
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <target_host> <port_range>"
    echo "Example: $0 example.com 1-100"
    exit 1
fi

# Parse arguments
target_host="$1"
port_range="$2"

# Split the port range into start and end
IFS='-' read -ra port_range_array <<< "$port_range"
start_port="${port_range_array[0]}"
end_port="${port_range_array[1]}"

# Perform the port scan
for ((port = start_port; port <= end_port; port++)); do
    (echo >/dev/tcp/$target_host/$port) 2>/dev/null
    result=$?
    if [ $result -eq 0 ]; then
        echo "Port $port is open"
    fi
done
# code above may have time issue with firewall(filtered, no response)
# use `nc host portrange1-portrange2 -zv -w 1` instead
