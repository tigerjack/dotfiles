alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -h --color=auto'
alias ll='ls -lh'
alias lal='ls -Alh'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias sxf="export FIRST_DISPLAY='1' && startx >$HOME/logs/startx/all.log 2>&1"
alias dotfiles_mgmt='/usr/bin/git --git-dir=$HOME/.git_dotfiles/ --work-tree=$HOME'
alias prog_mgmt='/usr/bin/git --git-dir=/mnt/internal/ProgrammingData/.git_prog_mgmt/ --work-tree=/mnt/internal/ProgrammingData'
alias winq464_old='export WINEARCH=win64 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64_old && '
alias winq464='export WINEARCH=win64 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64 && '
alias winq432='export WINEARCH=win32 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_32 && '
alias winq432_2='export WINEARCH=win32 export WINEPREFIX=/mnt/internal/LinuxData/wine/q4_32_2 && '
alias gcalcli='gcalcli --configFolder=/home/tigerjack/.config/gcalcli'
alias gcalclit='gcalcli --configFolder=/home/tigerjack/.config/gcalcli --calendar=tigerjack89@gmail.com'
alias gcalclir='gcalcli --configFolder=/home/tigerjack/.config/gcalcli --calendar=Ripetizioni'
alias mnemosyne='mnemosyne -d /mnt/internal/Data/PersonalFolder/AppData/Mnemosyine'
alias emt='emacsclient -t'
alias emcn='emacsclient -cn'
alias emn='emacsclient -n'
alias mutt='mutt -F ~/.config/neomutt/neomuttrc'
alias anki='anki -b /mnt/internal/Data/PersonalFolder/AppData/Anki'
alias wfh='sudo netctl start wlp2s0-TP-LINK_8340'
alias wfp='sudo netctl start wlp2s0-polimi'
alias wfw='sudo netctl start wlp2s0-HUAWEI'
alias wfs='sudo netctl stop-all'
alias gitlg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gitlg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
