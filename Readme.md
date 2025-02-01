My git dotfiles repo containing all relevant configurations.

* Post-install steps
0. Set hostname if not already specified inside /etc/hostname
1. Set graphic cards in .env_gui
2. Set relevant dirs in .env_global
3. Execute generate_from_global_env
4. Execute switch_theme.sh. Note that theme lines are untracked from git using this method https://stackoverflow.com/questions/6557467/can-git-ignore-a-specific-line

