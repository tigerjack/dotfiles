from i3pystatus import Status

status = Status(logfile='$MDIR_LOGS/i3pystatus.log')

# Simple module to invoke pcmanfm-qt and switch to "MOUSE MODE"
status.register("text",
        text="QT",
        color="#0055FF",
        on_leftclick="pcmanfm-qt --desktop"
)

# Displays clock 
status.register("clock",
    format="%a%-d%b%X",
    color="#00ffaa",
    on_leftclick = "urxvt -e bash -c 'cal -3 && bash' ",
    on_rightclick = "urxvt -e bash -c 'gcalcli --configFolder=~/.config/gcalcli --calendar=tigerjack89@gmail.com calm && bash' ",
)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",
    color_muted="#FFAA00",
    on_leftclick = "urxvt -e pulsemixer",
    on_rightclick = "pamixer --toggle-mute",
    on_upscroll = "pamixer --increase 5",
    on_downscroll = "pamixer --decrease 5",
)

# Shows your CPU temperature, if you have a Intel CPU
# For AMD CPU I've commented formatting options and disabled lm_sensors
status.register("temp",
    lm_sensors_enabled = False,
    format="{temp:.0f}°C",
#    lm_sensors_enabled = True,
#    format="{Core_0}-{Core_1}-{Core_2}-{Core_3}",
    hints={"markup": "pango"},
    dynamic_color=True,
    alert_temp=65,
    on_leftclick = "urxvt -e htop",
)

status.register("battery",
     format="{percentage:.0f}%{status}{remaining:%E%hh:%Mm}",
     alert=True,
     interval=30,
     alert_percentage=5,
     alert_timeout=10,
     color="#00ffaa",
     charging_color="#0055ff",
     full_color="#ffaa00",
     status={
         "DIS": "↓",
         "CHR": "↑",
         "FULL": "=",
     },)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    color="#00ffaa",
    critical_limit=2,
    on_leftclick = "urxvt -e htop",
)

# Cpu frequency
status.register("cpu_freq",
        format="{core0g}-{core1g}GHz",
        color="#00ffaa",
)

# Memory
status.register("mem",
        format="{percent_used_mem}%/{total_mem}GiB",
        divisor = 1024**3,
        color="#0055ff",
        warn_color="#ffaa00",
        alert_color="#ff0055",
        on_leftclick = "urxvt -e htop",
)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlp3s0",
    #format_up="{essid}{quality:3.0f}%\u2197{bytes_sent}\u2198{bytes_recv}KB/s",
    format_up="\u2197{bytes_sent}\u2198{bytes_recv}KiB/s",
    format_down="{interface} \u2013",
    on_leftclick = "nm-connection-editor",
    on_rightclick = "urxvt -e bash -c 'sudo nethogs wlp3s0'",
    start_color="#00ffaa",
    end_color="#ff0055",
    separate_color="True",
    hints={"markup": "pango"},
)
status.run()
