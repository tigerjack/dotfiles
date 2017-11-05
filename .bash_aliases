alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias lal='ls -Al'
alias startxm='startx &> $HOME/.startx/all.log'
alias dotfiles_mgmt='/usr/bin/git --git-dir=$HOME/.git_dotfiles/ --work-tree=$HOME'
alias prog_mgmt='/usr/bin/git --git-dir=/mnt/internal/LinuxData/Programming/.git_prog_mgmt/ --work-tree=/mnt/internal/LinuxData/Programming'
alias win64='env WINEPREFIX=/mnt/internal/LinuxData/wine/64/ wine'
alias win32='env WINEARCH=win32 env WINEPREFIX=/mnt/internal/LinuxData/wine/32/ wine'
alias ppush='echo $PWD > ~/.pdir.txt'
alias ppop='cd `cat ~/.pdir.txt`'
alias pget='echo `cat ~/.pdir.txt`'
alias gcalclim='gcalcli --configFolder=/home/tigerjack/.config/gcalcli --calendar=tigerjack89@gmail.com'
alias emt='emacsclient -t'
alias emtn='emacsclient -t -n'
alias mutt='mutt -F ~/.config/neomutt/neomuttrc'
