#!/usr/bin/bash

rm /tmp/.X0-lock &>/dev/null || true

export DISPLAY=:0
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
echo "Starting X in 2 seconds"
sleep 2
startx 

while :
do
	echo "startx failed, so we will just wait here while you debug!"
	sleep 30
done

# CUPS
# Tell the container that DBUS should report to Host OS
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

# Set rules for connection only through the public device URL
iptables -A INPUT -i resin-vpn -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -i resin-vpn -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j REJECT

# cupsd -f

# # BROWSER
# chromium-browser