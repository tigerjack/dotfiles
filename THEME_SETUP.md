# Theme switching setup

This dotfiles repo supports switching between a light and a dark theme
system-wide via `switch_theme.sh` and `~/.config/themes_config.cfg`, without
polluting `git status` every time the theme changes.

## How it works

`switch_theme.sh light|dark|def` drives every app. Most apps follow a
generic, config-driven mechanism; a few need bespoke handling because their
config format has no "include" concept. Both mechanisms exist for the same
reason: **the file git tracks should never be the file that gets rewritten
on every theme switch.**

### Mechanism 1: template -> generated file (sed-based)

Driven by `themes_config.cfg`, one line per setting:

```
name:file:pattern:light_value:dark_value
```

For each entry, `switch_theme.sh`:

1. Reads the **tracked template**, `file` (always ends in `.@theme`).
2. Copies it once to the **generated file** (same path, `.@theme` suffix
   stripped) the first time that output file is touched in a run.
3. Runs `sed` on the generated file only, replacing whatever matches
   `pattern` with `light_value` or `dark_value`.

The generated file is **gitignored**; the template is the only thing
tracked, and templates never change on a theme switch. This covers GTK 2/3/4,
Qt5/Qt6, taskwarrior, speedcrunch, zathura, cht.sh, and bat.

Apps in this group: the app reads its **entire** live config from the
generated file, and that file is either fully disposable (GTK, Qt, cht.sh)
or has no other content worth preserving separately from the template.

### Mechanism 2: split out just the theme line (source/include-based)

Used where the live config file is large, hand-edited, and you want to keep
editing it directly (vim's `vimrc`, ranger's `rc.conf`, Spacemacs' `init.el`,
kitty's `kitty.conf`). Splitting the *entire* file through mechanism 1 would
mean losing the "edit it directly" property, since every regeneration starts
from the tracked template.

Instead:

- The main config file is tracked and edited normally. It contains one
  static line that never needs to change:
  - vim: `source $XDG_CONFIG_HOME/vim/local-theme.vim`
  - ranger: `source $XDG_CONFIG_HOME/ranger/local-theme.conf`
  - Spacemacs (`init.el`): `(load (expand-file-name "local-themes.el" ...) t)`
  - kitty: `include current-theme.conf`
- The included file is **gitignored** and is the only thing mechanism 1
  regenerates/rewrites on a theme switch.
- For Spacemacs specifically: `init.el` reads `dotspacemacs-themes` from a
  variable (`my-dotspacemacs-themes`) that's set by the generated file, so
  the theme *order* (which theme loads first) lives outside git too.

### Mechanism 3: environment variable override (`bat`)

`bat`'s config file has no `source`/`include` directive at all. Instead of
regenerating the whole config, we rely on `bat` honoring the `BAT_THEME`
env var over its config file's `--theme=`:

- `config` (tracked) is edited directly and has no `--theme=` line (or a
  hardcoded fallback).
- `local-theme.sh` (gitignored) is generated from a tracked
  `local-theme.sh.@theme` template and just does `export BAT_THEME="..."`.
- Your shell rc sources it:
  `[ -f "$XDG_CONFIG_HOME/bat/local-theme.sh" ] && source "$XDG_CONFIG_HOME/bat/local-theme.sh"`

Caveat: this only takes effect in shells that (re)source it after a switch —
already-open terminals need a fresh `source ~/.bashrc` or a new shell.

### kitty: no filter needed

`kitty.conf` just has a static `include current-theme.conf` line, committed
once and never touched again. `current-theme.conf` is gitignored and holds
the actual palette.

There used to be a `.gitattributes` clean/smudge filter (`filter=kittytheme`)
trying to strip a `BEGIN_KITTY_THEME` / `END_KITTY_THEME` comment block from
`kitty.conf` on commit. It's gone now, for two reasons:

- **It was broken.** `smudge = cat` never reconstructed the block on
  checkout, so a fresh clone silently ended up with no `include` line and no
  working theme.
- **It was solving the wrong problem.** The root cause wasn't "git needs to
  ignore this block," it was that `kitty +kitten themes --reload-in=all`
  writes theme colors *and* rewrites the include block *inside `kitty.conf`
  itself* every time you switch. As long as anything writes to a tracked
  file on every switch, no clean/smudge trick fully hides it — `git status`
  and `git diff` can disagree with each other when a filter is involved
  (confirmed while debugging this: `status` kept showing `kitty.conf` as
  modified with an empty `diff`, and even `update-index --refresh` didn't
  clear it — only `git add`, i.e. actually re-filtering and re-hashing,
  did). That's git faithfully reporting a file that a filter is fighting to
  keep looking stable, not a bug worth working around.

The actual fix was to stop the write from touching `kitty.conf` at all,
using kitty's own `--dump-theme` flag (prints a theme's palette to stdout
instead of writing it into `kitty.conf`) plus remote control for live reload
of already-open windows:

```sh
kitty +kitten themes --dump-theme "$kittystyle" > "$XDG_CONFIG_HOME/kitty/current-theme.conf"
kitty @ set-colors --all --configured "$XDG_CONFIG_HOME/kitty/current-theme.conf" 2>/dev/null || true
```

This needs `allow_remote_control` and `listen_on` set once in `kitty.conf`
(static, tracked, never changes). With this, `kitty.conf` is genuinely
never rewritten after the initial `include` line goes in — same guarantee
mechanism 2 gives vim/ranger/spacemacs, just reached by changing *what
kitty is told to do* instead of trying to filter its output after the fact.

**General lesson from this one:** prefer stopping a tool from writing to a
tracked file over adding a git filter to hide that it did. Filters are
asymmetric (clean/smudge can drift out of sync, as here) and only paper
over the symptom; check for a flag/env-var/API that avoids the write
before reaching for `.gitattributes`.

## Files not toggled by theme

`chtsh` (cheat.sh client) used to have a light/dark `style=` entry in
`themes_config.cfg`, but Pygments styles only recolor a small code snippet
and the difference wasn't worth the extra moving part, so it's set to a
single fixed style and removed from the theme-switching table.

## Adding a new app

- If the app's entire config is disposable/small: add a `.@theme` template
  + one line in `themes_config.cfg` (mechanism 1).
- If the app's config is large/hand-edited and supports `source`/`include`:
  split out a `local-theme.*` file (mechanism 2) and add a line in
  `themes_config.cfg` pointing at `local-theme.*.@theme`.
- If the app has neither: look for an environment variable override
  (mechanism 3) before resorting to git filters — filters are asymmetric
  (clean/smudge) and easy to leave broken in one direction, as the kitty
  example above shows.

In all cases: **whatever file actually gets rewritten by `switch_theme.sh`
must be gitignored.** The tracked file should only ever change when you
deliberately edit it.
