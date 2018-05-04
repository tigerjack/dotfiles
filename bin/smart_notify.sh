#!/bin/sh

notify-send -u critical -a "smartd" "S.M.A.R.T Error ($SMARTD_FAILTYPE): $SMARTD_MESSAGE"
