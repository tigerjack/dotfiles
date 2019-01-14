alias diff='diff --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias ls='ls -h --color=always'
alias ll='ls -lh'
alias lal='ls -Alh'
alias l1='ls -1'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias tmsu_uni='tmsu -D /mnt/internal/DatiSimone/AppData/tmsu/university'
alias tmsu_vid='tmsu -D /mnt/internal/DatiSimone/AppData/tmsu/video'
alias td='transmission-daemon'
alias zx="export FIRST_DISPLAY='1' && startx >$MDIR_LOGS/startx/all.log 2>&1"
alias dotfiles_mgmt='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
alias prog_mgmt='/usr/bin/git --git-dir=$MDIR_PROGRAMMING_DATA/.git/ --work-tree=$MDIR_PROGRAMMING_DATA'
alias gcalcli='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli'
alias gcalclit='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=tigerjack89@gmail.com'
alias gcalclir='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=Ripetizioni'
alias gcalclip='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=perriellanza'
alias emt='emacsclient -t'
alias emcn='emacsclient -cn'
alias emn='emacsclient -n'
alias mutt='mutt -F $XDG_CONFIG_HOME/neomutt/neomuttrc'
alias gitlg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gitlg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias ecl='env SWT_GTK3=0 eclipse'
alias wn32='WINEARCH=win32 WINEPREFIX=~/LinuxData/wine32'
alias wn64='WINEPREFIX=~/LinuxData/wine64'
