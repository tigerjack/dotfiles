alias diff='diff --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -h --color=always'
alias ll='ls -lh'
alias lal='ls -Alh'
alias l1='ls -1'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias tmsu_uni='tmsu -D $MDIR_GLOBAL_APP_DATA/tmsu/university'
alias tmsu_vid='tmsu -D $MDIR_GLOBAL_APP_DATA/tmsu/video'
alias tmsu_the='tmsu -D $MDIR_GLOBAL_APP_DATA/tmsu/thesis'
alias td='transmission-daemon'
alias zx="export FIRST_DISPLAY='1' && startx -- -keeptty >$MDIR_LOGS/startx/xorg.log 2>&1"
alias dotfiles_mgmt='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
alias prog_mgmt='/usr/bin/git --git-dir=$MDIR_PROGRAMMING_DATA/.git/ --work-tree=$MDIR_PROGRAMMING_DATA'
alias gcalcli='gcalcli --config-folder=$XDG_CONFIG_HOME/gcalcli'
alias gcalclit='gcalcli --config-folder=$XDG_CONFIG_HOME/gcalcli --calendar=tigerjack89@gmail.com'
alias gcalclir='gcalcli --config-folder=$XDG_CONFIG_HOME/gcalcli --calendar=Ripetizioni'
alias gcalclip='gcalcli --config-folder=$XDG_CONFIG_HOME/gcalcli --calendar=perriellanza'
alias emt='emacsclient -t'
alias emcn='emacsclient -cn'
alias emn='emacsclient -n'
alias spwnd='spawn_x_terminals_into_pwd.sh'
alias mutt='mutt -F $XDG_CONFIG_HOME/neomutt/neomuttrc'
alias gitlg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gitlg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias ecl='env SWT_GTK3=0 eclipse'
alias wn32='WINEARCH=win32 WINEPREFIX=$MDIR_LINUX_DATA/wine32'
alias wn64='WINEPREFIX=$MDIR_LINUX_DATA/wine64'
alias wnoffice='WINEARCH=win32 WINEPREFIX=$MDIR_LINUX_DATA/wine_office'
alias stellarium='stellarium -c $XDG_CONFIG_HOME/stellarium/config.ini -u $XDG_DATA_HOME/stellarium --screenshot-dir $MDIR_SCREENSHOTS/stellarium'
alias irssi='irssi --config=$XDG_CONFIG_HOME/irssi/config --home=$XDG_DATA_HOME/irssi'
alias 5m='find ~/ ! -path "/home/simone/.mozilla/*"  ! -path "/home/simone/.cache/*" ! -path "/home/simone/.eclipse/*"! -path ".config/google-chrome/*" ! -path "~/.config/libreoffice/4/user/*" ! -mmin -5 -type f -ls'
alias mynote="vim $(xdg-user-dir DOCUMENTS)/Notes/FastNotes.txt"
alias snclip="sncli -c $MDIR_PRIVATE/sncli/snclirc_personal"
alias sncliw="sncli -c $MDIR_PRIVATE/sncli/snclirc_work"
alias mycli="mycli --myclirc $XDG_CONFIG_HOME/mycli/myclirc"
alias incognito_on="shopt -uo history"
alias incognito_off="shopt -so history"
alias onedriveatos='onedrive --confdir $XDG_CONFIG_HOME/onedrive/atos/'
alias onedrivepolimi='onedrive --confdir $XDG_CONFIG_HOME/onedrive/polimi/'
