#!/usr/bin/sh
slt=90
if [ -x /usr/bin/gcalcli ]; then
    echo "gcalcli detected"
    while true; do
        nc -z 8.8.8.8 53  >/dev/null 2>&1
        online=$?
        if [ $online -eq 1 ]; then
            echo "Connection established"
            /usr/bin/gcalcli --configFolder='/home/tigerjack/.config/gcalcli' --calendar='tigerjack89@gmail.com' remind 120 'notify-send -u "critical" %s'
            sleep 720 # 120 min, as above
        else
            if [ "$slt" -ge 6000 ]; then
                slt=6000
            else
                let "slt=slt*3/2"
            fi
            echo "Connection refused. Retrying again in $slt seconds"
        fi
        sleep $slt
    done #&
fi
