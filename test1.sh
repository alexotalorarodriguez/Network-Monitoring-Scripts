#!/bin/bash

# Establecer variables de entorno para permitir el uso de notify-send
export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
ADDRESS_TEST="8.8.8.8" 

# Función para enviar una notificación
function send_alert() {
    fecha=$(date +"%Y-%m-%d %H:%M:%S")
    mensaje="La conexión a Internet está caída"
    #/usr/bin/zenity --info --text="Alerta de red  " "$fecha - $mensaje"
    /usr/bin/zenity --info --text="ALERTA DE RED!!!\n\n$fecha - $mensaje"
    exit 1
}

function send_ok() {
    fecha=$(date +"%Y-%m-%d %H:%M:%S")
    mensaje="¡La conexión a Internet está OK!"
    #/usr/bin/zenity --info --text="Alerta de red" "$fecha - $mensaje"
    #/usr/bin/zenity --info --text="Alerta de red\n$fecha - $mensaje"

}

if ping -c 3 -W 1 $ADDRESS_TEST > /dev/null 2>&1; then
    # La conexión está activa
    #send_ok
    exit 1
else
    send_alert
fi