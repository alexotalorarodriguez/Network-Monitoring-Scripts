#!/bin/bash
###
USERLIST=($(who | sed -e 's/[)(]//g' -e 's/  */ /g' | cut -d ' ' -f1,5 | sort -u | tr -d '\n'))
LOG=/tmp/"$(basename $0)".log
###
echo "$(who | sed -e 's/[)(]//g' -e 's/  */ /g')" >> $LOG
echo "${USERLIST[@]}" >> $LOG
C=0
while [ $C -lt ${#USERLIST[@]} ]
    do
        D=$((C + 1))
        export DISPLAY="${USERLIST[$D]}"
        export XAUTHORITY="/home/${USERLIST[$C]}/.Xauthority"
        export XDG_RUNTIME_DIR=/run/user/$(id -u ${USERLIST[$C]})
        /usr/bin/notify-send 'shutdown warning'
        C=$((C + 2))
    done