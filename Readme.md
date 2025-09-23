My git dotfiles repo containing all relevant configurations.

# Post-install steps
## Preliminaries
Install a few utility that we'll need later
```sh
pacman -S \
    git \
    openssh \
    zsh \
    inet-utils \ # for hostname
```

To facilitate the process, copy your ssh keys into your .ssh dir. In this
way, you can use an ssh-agent.

Then, clone the git repo in your user dir using

```sh
git clone --bare git@github.com:tigerjack/dotfiles.git ~/.cfg`
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
```

## Some dotfiles configs 
### Kitty
Note that this is an attempt, but I still don't know if successful.

```
dotfiles_mgmt config filter.kittytheme.clean "sed '/# BEGIN_KITTY_THEME/,/# END_KITTY_THEME/ d'"
dotfiles_mgmt config filter.kittytheme.smudge "cat"
```
The `.gitattributes` file should contain the line
```
.config/kitty/kitty.conf filter=kittytheme
```

In this way,
- `clean` Deletes lines between BEGIN_KITTY_THEME and END_KITTY_THEME when committing.
- `smudge` Leaves the file unchanged when checking it out, preserving local modifications.

## Post git clone
0. Set hostname if not already specified inside /etc/hostname
1. Set graphic cards in .env_gui
2. Set relevant dirs in .env_global
3. Execute generate_config
4. Execute switch_theme.sh
5. Enable systemd units. Specifically
```bash
systemctl --user daemon-reload
systemctl --user enable clean_tmp.timer
systemctl --user enable mako.service
systemctl --user enable kanshi.service
```

## Useful installs

### windows manager
```sh
pacman -S \
    sway \
    swayidle \
    swaylock \
    waybar \
    wofi \
    xdg-user-dirs \
    networkmanager
```

### terminals
```sh
pacman -S \
    kitty
    ttf-font-awesome \
    ttf-fira-code \

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

for themes
```sh
kitty +kittens
```
and select Misterioso, then copy option

### spacemacs

```sh
pacman -S \
    emacs
    ttf-adobe-source-code-pro-fonts \ # mainly emacs

git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
```

You should also configure langtool and the tigerjack layer

### Qt/Gtk
Install the icon theme Arc

### git projects
On old machine, go to `vc` dir and
```sh
list_git_repos.sh . > repos.json
```

On the new one, do 

```sh
restore_git_repos.sh repos.json .
```

### others
- zotero
- zathura
- rclone
- zoom
- protonvpn
- pdf xchange 6 (come with rcloning)
- pdf xchange 10
- signal
- libreoffice
- virtualbox (have to import machines)
- keybase
- veracrypt
- keepassxc
- spotify
- syncthing
- git projects wip
- pyenv (and virtualenv plugin)


## Other useful things to do
###  Move firefox cache dirs
https://support.mozilla.org/en-US/questions/955978

That is, FOR EACH PROFILE
0. mkdir -p .cache/firefox/PROFILE_NAME (f.e. krxbnl3b.polimi)
1. about:config
2. search for browser.cache.disk.parent_directory 
3. mod to string, and add something like /home/simone/.cache/firefox/PROFILE_NAME

### Move emacs cache dir
```sh
mv .emacs.d/.cache/ .cache/emacs
ln -s ~/.cache/emacs/ .emacs.d/.cache
```

### Check GPU and rendering
```sh
❯ lspci -k | grep -A 3 -E "VGA|3D"
❯ glxinfo -B | grep -E "Device|Renderer|OpenGL"
```
