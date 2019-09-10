from i3pystatus import Status
import logging
from i3pystatus.updates import pacman
from i3pystatus.weather import weathercom, wunderground

status = Status(logfile='$MDIR_LOGS/i3/i3pystatus.log')

# Simple module to invoke pcmanfm-qt and switch to "MOUSE MODE"
status.register("text",
        #text="\u235d",
        text="🖱",
        color="#cccccc",
        on_leftclick="mouse_mode_on.sh",
        on_rightclick="mouse_mode_off.sh"
)
status.register("text",
    #text="\u262f",
    text="🗓",
    color="#cccccc",
    on_leftclick="urxvt -e sh -c 'task list && $SHELL'",
    on_rightclick="urxvt -e sh -c 'gcalcli --config-folder=~/.config/gcalcli --calendar=tigerjack89@gmail.com calm && $SHELL' ",
)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",
    format_muted="\u2209\u266b{volume}",
    color_muted="#FFAA00",
    color_unmuted="#009aff",
    on_leftclick = "urxvt -e pulsemixer",
    on_rightclick = "pamixer --toggle-mute",
    on_upscroll = "pamixer --increase 5",
    on_downscroll = "pamixer --decrease 5",
)

# Displays clock 
status.register("clock",
    #format="%-d%b%X",
    format="%-d%b%H:%M",
    color="#00ff65",
    on_leftclick = "urxvt -e bash -c 'cal -m -3 && bash' ",
    on_rightclick = "xclock -digital -update 1",
)

status.register("shell",
    #command="curl http://wttr.in/Milan?format=3",
    #command="curl http://wttr.in/Milan?format='+%c+%t,+%w+%m'",
    #command="curl -s http://wttr.in/Milan?format='+%m+%w' | awk -F' ' '{print $1 $2 \"\u224a\"}'",
    # command="wttr_wrapper.sh",
    command="wttr_wrapper.py",
    interval=3600,
    on_leftclick='termite --hold -e "curl http://v2.wttr.in/Milan"',
    on_rightclick='termite --hold -e "curl http://wttr.in/Milan"',
)

# Doesn't work
# status.register('weather',
#     format='[{icon}]{current_temp}({low_temp}/{high_temp}){temp_unit}[ {update_error}]',
#     colorize=True,
#     hints={'markup': 'pango'},
#     log_level=logging.DEBUG,
#     backend=weathercom.Weathercom(
#         location_code='20126:4:IT',
#         log_level=logging.DEBUG,
#         update_error='!',
#     ),
#     on_leftclick="urxvt --hold -e curl http://wttr.in/Milan",
#     # on_rightclick="urxvt --hold -e curl http://wttr.in",
# )

status.register("xkblayout",
    #format="\u2328{symbol}",
    format="👅 {symbol}",
    layouts=["us", "it"],
    interval=1000
)

status.register("updates",
    format = "\u27f3{count}",
    backends = [pacman.Pacman()],
    interval=18000,
    #  gives ==> ERROR: Cannot fetch updates most of the time
    on_leftclick = "urxvt --hold -e bash -c 'checkupdates'",
    on_rightclick = "urxvt --hold -e sudo pacman -Syu",
)

status.register("shell",
    command="printf '🐧' && uname -r | cut -d '-' -f 1",
    color="#009aff",
    on_leftclick = "urxvt --hold -e uname -a",
    on_rightclick = "urxvt --hold -e neofetch",
    interval=18000
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
        format="🔋{percentage:.0f}%{status}{remaining:%E%h:%M}",
     interval=30,
     # Not used, I use my own script
     # alert=True,
     alert_percentage=10,
     alert_timeout=10,
     # color="#00ffaa",
     # charging_color="#0055ff",
     full_color="#ff0000",
     status={
         "DIS": "↓",
         "CHR": "↑",
         "FULL": "\u26a0",
     },)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    format="{avg1}\u03bc",
    color="#ff009a",
    critical_limit=2,
    on_leftclick = "urxvt -e htop -s PERCENT_CPU",
)

# Cpu frequency
status.register("cpu_freq",
        #format="{core0g}-{core1g}GHz",
        format="{core0g}\u03c9",
        color="#009aff",
)

# Memory
status.register("mem",
        #format="{percent_used_mem}%/{total_mem}",
        #format="\u2592{percent_used_mem}%",
        #format="🧠{percent_used_mem}%",
        #format="🐘{percent_used_mem}%",
        format="🐏{percent_used_mem}%",
        divisor = 1024**3,
        color="#0055ff",
        warn_color="#ffaa00",
        alert_color="#ff0055",
        on_leftclick = "urxvt -e htop -s PERCENT_MEM",
)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="enp0s8",
    #format_up="{essid}{quality:3.0f}%\u2197{bytes_sent}\u2198{bytes_recv}KB/s",
    #format_up="\u2198{bytes_recv}\u2197{bytes_sent}\u23d0\u03bd\u232a",
    format_up="\u2198{bytes_recv}\u2197{bytes_sent} ⃓v❭",
    format_down="{interface}\u2013",
    on_leftclick = "nm-connection-editor",
    on_rightclick = "urxvt -e bash -c 'sudo nethogs wlp3s0'",
    start_color="#00ffaa",
    end_color="#ff0055",
    separate_color="True",
    hints={"markup": "pango"},
)

status.run()
