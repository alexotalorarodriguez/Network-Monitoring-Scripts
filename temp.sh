#!/bin/bash

# Número de intentos exitosos requeridos para considerar que la conexión ha regresado
NUM_EXITOS=8

# Dirección IP de Google
GOOGLE_IP="8.8.8.8"

# Dirección de correo electrónico proporcionada como argumento al script
email=$1

# Función para enviar correo electrónico
send_email() {
    echo "This message is automated and its purpose is inform you the network was restored." | mail -s "Internet connection restored" $email
    exit 0
}

# Bucle infinito para monitorear el regreso de la conexión
while true
do
    # Realizar 10 pings a Google
    exitos=0
    for ((i=1; i<=10; i++))
    do
        ping -c 1 $GOOGLE_IP > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            ((exitos++))
        fi
    done

    # Si el número de pings exitosos es mayor o igual al umbral establecido, enviar correo y salir del script
    if [ $exitos -ge $NUM_EXITOS ]; then
        send_email
    fi

    # Esperar antes de volver a verificar
    sleep 30 # Espera 30 segundos antes de volver a verificar
done
