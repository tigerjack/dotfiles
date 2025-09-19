My git dotfiles repo containing all relevant configurations.

# Post-install steps
0a. some prelimiary installations
```sh
pacman -S \
    git \
    openssh \
    zsh \
    inet-utils \ # for hostname
```
0b. copy your ssh keys into your .ssh dir

0c. clone git repo in your user dir using

```sh
git clone --bare git@github.com:tigerjack/dotfiles.git ~/.cfg`
```

then 
```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

1. execute
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

2. GUI install

```sh
pacman -S \
    sway \
    wofi \
    waybar \
    xdg-user-dirs \
    networkmanager \
    kitty \
    ttf-font-awesome \
    ttf-fira-code \

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

* Post git clone
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


# Other useful things to do
##  Move firefox cache dirs
https://support.mozilla.org/en-US/questions/955978

That is, FOR EACH PROFILE
0. mkdir -p .cache/firefox/PROFILE_NAME (f.e. krxbnl3b.polimi)
1. about:config
2. search for browser.cache.disk.parent_directory 
3. mod to string, and add something like /home/simone/.cache/firefox/PROFILE_NAME

## Move emacs dir
>mv .emacs.d/.cache/ .cache/emacs/
>ln -s .cache/emacs/ .emacs.d/.cache

