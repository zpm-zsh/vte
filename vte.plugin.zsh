#!/usr/bin/env zsh

_zpm__vte_urlencode() (
  # This is important to make sure string manipulation is handled
  # byte-by-byte.
  LC_ALL=C
  str="$1"
  while [ -n "$str" ]; do
    safe="${str%%[!a-zA-Z0-9/:_\.\-\!\'\(\)~]*}"
    printf "%s" "$safe"
    str="${str#"$safe"}"
    if [ -n "$str" ]; then
      printf "%%%02X" "'$str"
      str="${str#?}"
    fi
  done
)

_zpm__vte_osc7 () {
  printf "\033]7;file://%s%s\033\\" "${HOSTNAME:-$HOST}" "$(_zpm__vte_urlencode "${PWD}")"
  printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME:-$HOST}" "$(_zpm__vte_urlencode "${PWD}")"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _zpm__vte_osc7
_zpm__vte_osc7
