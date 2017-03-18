#!/bin/bash

FREQ=30

while [[ $# -gt 1 ]]
do
	key="$1"

	case $key in
		-c|--connection)
			CONN_NAME="$2"
			shift
			;;
		-f|--freq)
			FREQ="$2"
			shift
			;;
		-h|--help)
			echo 'Usage: ./vpn_reconnect.sh -c [connection_name] [-f [frequency]]'
			;;
	esac
	shift
done

if [[ -z $CONN_NAME ]]; then
	echo 'Error: You must supply the -c argument'
	exit 1
fi

while true
do
	VPNCON=$(nmcli con show --active | grep "$CONN_NAME" | cut -f1 -d " ")
	if [[ $VPNCON != "$CONN_NAME" ]]; then
		echo "Disconnected, trying to reconnect..."
		VPNUUID=$(nmcli con show | grep "$CONN_NAME.*vpn" | awk -F" " '{print $2}')
		if [[ $VPNUUID != "" ]]; then
			nmcli con up uuid "$VPNUUID"
		else
			echo 'Error: Connection not found!'
			exit 1
		fi
	fi
	sleep "$FREQ"
done
