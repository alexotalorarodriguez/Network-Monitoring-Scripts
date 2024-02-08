# Network Monitoring Scripts

Este repositorio contiene scripts Bash diseñados para monitorear y realizar tareas relacionadas con la red. Estos scripts son útiles para diagnosticar, automatizar y mantener la infraestructura de red de manera eficiente.

## Instrucciones Generales

- Asegúrate de tener los permisos necesarios para ejecutar los scripts, otorgue los permisos de ejecucion para todos los scripts a ejecutar:
   1. `chmod +x script.sh`
- Almacena archivos de configuración en una carpeta separada si es necesario.


## Contenido

1. **mail.sh**
   - Descripción: Script que realiza la instalacion y configuracion de postfix (servicio que permite el envio de correos electronicos) y debe ser ejecutado como primero en la lista.
   - Ejecucion: `sudo ./mail.sh`

2. **status.sh**
   - Descripción: Script para revisar el estado de la conexion a internet, verifica la conexion a internet y en el caso de que el estado sea Down envia un mensaje de alerta en la pantalla.
   - Ejecucion:
      1. crontab -e
      2. añadir la siguiente linea `* * * * * /home/dev17pc/Documentos/code/Network-Monitoring-Scripts/status.sh` remplace con la ruta correcta al script

3. **return.sh**
   - Descripción: Script que permite monitorear el rertorno de la conexion a internet, una vez que la conexion se restablesca el script envia un correo electronico informativo.

