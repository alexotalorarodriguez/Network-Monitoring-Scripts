#!/bin/bash

# Configuration variables
ADDRESS_TEST="8.8.8.8"  # Address target to check internet connection - ping to google dns
WAIT=6                  # time to wait (in seconds) before next attempt
MAX_REPETITIONS=10      # Number of repetitions of the loop
MAX_COUNTER=8           # counter of max attempts to consider that the connection is down

# Function to send a notification
function send_alert() {
    notify-send "Network Alert" "The internet connection is down"      # for desktop environment
    #echo "$(tput setaf 1)¡Alerta!$(tput sgr0) La conexión a Internet está caída. Verifique su conexión."    # for terminal environment
}

# Main loop
repetition_counter=0
down_counter=0

while [ $repetition_counter -lt $MAX_REPETITIONS ]; do
    # checking connectivity
    if ping -c 1 -W 1 $ADDRESS_TEST > /dev/null 2>&1; then
        # the connection is up
        repetition_counter=0  # reset repetition counter if the connection is up
    else
        # The connection is down
        ((down_counter++))  # Incrementa el contador de conexiones down

        # check if max counter is reached
        if [ $down_counter -ge $MAX_COUNTER ]; then
            send_alert
            down_counter=0  # reset down counter after alert
        fi
    fi

    # Increment repetition counter
    ((repetition_counter++))

    # wait before next attempt
    sleep $WAIT
done

# Verificar si la cantidad del contador en down es mayor a 8
if [ $down_counter -gt 8 ]; then
    echo "La conexión estuvo down más de 8 veces."
fi
