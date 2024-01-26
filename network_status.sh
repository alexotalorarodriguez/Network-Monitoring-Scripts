#!/bin/bash

# Configuration variables
ADDRESS_TEST="8.8.8.8"  # Address target to check internet connection - ping to google dns
WAIT=6            # time to wait (in seconds) before next attempt
MAX_COUNTER=5      # counter of max attempts to cosider that the connection is down

# Function to send a notification
function send_alert() {
    notify-send "Network Alert" "The internet connection is down"      # for desktop environment
    #echo "$(tput setaf 1)¡Alerta!$(tput sgr0) La conexión a Internet está caída. Verifique su conexión."    # for terminal environment

}

# Main loop
counter=0

while true; do
    # checking conectivity
    if ping -c 1 -W 1 $ADDRESS_TEST > /dev/null 2>&1; then
        # the connection is up
        counter=0
    else
        # The connection is down
        ((counter++))

        # check if max counter is reached
        if [ $counter -ge $MAX_COUNTER ]; then
            send_alert
            counter=0  # restart counter after alert
        fi
    fi

    # wait before next attempt
    sleep $WAIT
done
