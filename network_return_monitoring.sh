#!/bin/bash

# Configuración
DESTINO="8.8.8.8"          # Puedes cambiar la dirección IP a la que quieras hacer ping
ESPERA=10                   # Intervalo de tiempo entre cada intento (en segundos)
CONTADOR_MAX=3              # Número máximo de intentos antes de considerar la red como caída
ESPERA_RECUPERACION=600     # Tiempo de espera antes de enviar otra notificación de recuperación (en segundos)
LOG_FILE="/var/log/red_monitoreo.log"

# Variables de estado
en_linea=true
ultimo_evento=""

# Función para enviar una notificación
function enviar_notificacion() {
    notify-send "Estado de Red" "$1"
}

# Función para escribir eventos en el registro
function escribir_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Bucle principal
while true; do
    # Intentar hacer ping al destino
    if ping -c 1 -W 1 $DESTINO > /dev/null 2>&1; then
        # La conexión está activa
        if [ "$en_linea" = false ]; then
            en_linea=true
            mensaje="La red ha vuelto a estar en línea."
            enviar_notificacion "$mensaje"
            escribir_log "$mensaje"
            ultimo_evento="recuperada"
            sleep $ESPERA_RECUPERACION  # Esperar un tiempo antes de enviar otra notificación de recuperación
        fi
    else
        # La conexión está caída
        if [ "$en_linea" = true ]; then
            ((contador++))

            # Verificar si se alcanzó el contador máximo
            if [ $contador -ge $CONTADOR_MAX ]; then
                en_linea=false
                contador=0
                mensaje="La red está caída."
                enviar_notificacion "$mensaje"
                escribir_log "$mensaje"
                ultimo_evento="caída"
            fi
        fi
    fi

    # Esperar antes del próximo intento
    sleep $ESPERA
done
