alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -h --color=auto'
alias ll='ls -lh'
alias lal='ls -Alh'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias zx="export FIRST_DISPLAY='1' && startx >$MDIR_LOGS/startx/all.log 2>&1"
alias dotfiles_mgmt='/usr/bin/git --git-dir=$HOME/.git_dotfiles/ --work-tree=$HOME'
alias prog_mgmt='/usr/bin/git --git-dir=$MDIR_PROGRAMMING_DATA/.git_prog_mgmt/ --work-tree=$MDIR_PROGRAMMING_DATA'
alias winq464_old='export WINEARCH=win64 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64_old && '
alias winq464='export WINEARCH=win64 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64 && '
alias winq432='export WINEARCH=win32 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_32 && '
alias winq432_2='export WINEARCH=win32 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_32_2 && '
alias gcalcli='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli'
alias gcalclit='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=tigerjack89@gmail.com'
alias gcalclir='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=Ripetizioni'
alias gcalclip='gcalcli --configFolder=$XDG_CONFIG_HOME/gcalcli --calendar=perriellanza'
alias emt='emacsclient -t'
alias emcn='emacsclient -cn'
alias emn='emacsclient -n'
alias anki='anki -b $MDIR_GLOBAL_APP_DATA/Anki'
alias mnemosyne='mnemosyne -d $MDIR_GLOBAL_APP_DATA/Mnemosyine'
alias mutt='mutt -F $XDG_CONFIG_HOME/neomutt/neomuttrc'
alias gitlg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gitlg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
