#!/bin/bash
slt=90
if [ -x /usr/bin/gcalcli ] || [ -x ~/.local/bin/gcalcli ]; then
    echo "gcalcli detected"
    while true; do
        connection_check.sh
        online=$?
        if [ $online -eq 0 ]; then
            echo "Connection established"
            gcalcli --configFolder="$XDG_CONFIG_HOME/gcalcli" --calendar='tigerjack89@gmail.com' remind 120 'notify-send -u "critical" %s'
            sleep 720 # 120 min, as above
        else
            if [ "$slt" -ge 6000 ]; then
                slt=6000
            else
                #let "slt=slt*3/2"
		((slt=slt*3/2))
            fi
            echo "Connection refused. Retrying again in $slt seconds"
        fi
        sleep $slt
    done #&
fi
