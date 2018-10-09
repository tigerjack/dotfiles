from i3pystatus import Status

status = Status(logfile='$MDIR_LOGS/i3pystatus.log')

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
    format="%a %-d %b %X",
    on_leftclick = "urxvt -e bash -c 'cal -3 && bash' ",
    on_rightclick = "urxvt -e bash -c 'gcalcli --configFolder=~/.config/gcalcli --calendar=tigerjack89@gmail.com calm && bash' ",
)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    on_leftclick = "urxvt -e htop",
)

# Cpu frequency
status.register("cpu_freq",
        format="{core0g},{core1g}GHz",
)

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    lm_sensors_enabled = False,
    format="{temp:.0f}°C",
#    lm_sensors_enabled = True,
#    format="{Core_0}-{Core_1}-{Core_2}-{Core_3}",
#    hints={"markup": "pango"},
#    dynamic_color=True,
#    alert_temp=60,
#    on_leftclick = "urxvt -e htop",
)

status.register("mem",
        format="Mem: {percent_used_mem}%/{total_mem} GiB",
        divisor = 1024**3,
        on_leftclick = "urxvt -e htop",
)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
#status.register("battery",
#    format="{status}/{consumption:.2f}W {percentage:.2f}% [{percentage_design:.2f}%] {remaining:%E%hh:%Mm}",
#    alert=True,
#    alert_percentage=5,
#    status={
#        "DIS": "↓",
#        "CHR": "↑",
#        "FULL": "=",
#    },)

# This would look like this:
# Discharging 6h:51m
# Removed bcz problem w/ battery
status.register("battery",
     format="{percentage:.0f}%{status}{remaining:%E%hh:%Mm}",
     alert=True,
     interval=10,
     alert_percentage=5,
     alert_timeout=30,
     status={
         "DIS": "↓",
         "CHR": "↑",
         "FULL": "=",
     },)

# Displays whether a DHCP client is running
#status.register("runwatch",
#    name="DHCP",
#    path="/var/run/dhclient*.pid",)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
#status.register("network",
#    interface="",
#    format_up="{v4cidr}",)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
    interface="wlp3s0",
    format_up="{essid}{quality:3.0f}%\u2197{bytes_sent}KB/s\u2198{bytes_recv}KB/s",
    format_down="{interface} \u2013",
    on_leftclick = "urxvt -e bash -c 'sudo nethogs wlp3s0'",
)

# Shows disk usage of /
# Format:
# 42/128G [86G]
# status.register("disk",
#     path="/",
#     format="{used}/{total}G [{avail}G]",)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",
    on_leftclick = "urxvt -e pulsemixer",
    on_upscroll = "pamixer --increase 5",
    on_downscroll = "pamixer --decrease 5",
)

# Shows mpd status
# Format:
# Cloud connected▶Reroute to Remain
#status.register("mpd",
#    format="{title}{status}{album}",
#    status={
#        "pause": "▷",
#        "play": "▶",
#        "stop": "◾",
#    },)
status.run()
