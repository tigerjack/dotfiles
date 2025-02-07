My git dotfiles repo containing all relevant configurations.

# Post-install steps
0. clone git repo in your user dir using
```sh
git clone --bare git@github.com:tigerjack/dotfiles.git ~/.cfg`
```
1. execute
```
dotfiles_mgmt config --global filter.ignore-theme.clean "sed '/THEME_START/,/THEME_END/d'"
dotfiles_mgmt config --global filter.ignore-theme.smudge "cat"
```
It will
- `clean` Deletes lines between THEME_START and THEME_END when committing.
- `smudge` Leaves the file unchanged when checking it out, preserving local modifications.

* Post git clone
0. Set hostname if not already specified inside /etc/hostname
1. Set graphic cards in .env_gui
2. Set relevant dirs in .env_global
3. Execute generate_from_global_env
4. Execute switch_theme.sh. Note that theme lines are untracked from git using this method https://stackoverflow.com/questions/6557467/can-git-ignore-a-specific-line
5. Enable systemd units. For example
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

