#!/bin/bash
TTY=${TTY:-$(tty)}
TTY=${TTY#/dev/}

if [[ $TTY != tty* ]]; then
  printf '==> ERROR: invalid TTY\n' >&2
  exit 1
fi

printf -v vt 'vt%02d' "${TTY#tty}"
echo "$vt"
