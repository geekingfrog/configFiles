# Bind CTRL-Q to behave similarly to fzf CTRL-T (list files)
# except the input source is a flat file holding a list of
# all useful aws resources.
#
# This whole file is coming almost verbatim from the completion
# script bundled with fzf. On my linux it's under /usr/share/fzf/completion.zsh
# I only modified the functions used for CTRL-T and bound it to
# a different key.

{
[[ -o interactive ]] || return 0

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}


__fzf-sel() {
  # invoke fzf with the given command. Echo each selected result
  local cmd="$@"

  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval $cmd | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}


__aws-resource-sel() {
  local cache_dir="${XDG_CACHE_DIR:-${HOME}/.cache/goustoaws}"
  local cmd="cat ${cache_dir}/*.resource"
  __fzf-sel "$cmd"
}


aws-resource-widget() {
  LBUFFER="${LBUFFER}$(__aws-resource-sel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

__aws-resource-sel2() {
  setopt localoptions pipefail no_aliases errexit 2> /dev/null
  local cache_dir="${XDG_CACHE_DIR:-${HOME}/.cache/goustoaws}"
  local cmd="find $cache_dir -name '*.resource' | xargs -I {} basename {} .resource"

  cmd2="cat"
  for item in $( __fzf-sel "$cmd" )
  do
    file="${cache_dir}/${item}.resource"
    cmd2="${cmd2} $file"
  done

  __fzf-sel "$cmd2"

  echo
  return $ret
}

# Similar to aws-resource-widget but has an intermediate fzf prompt
# to select the desired resources
aws-resource-widget2() {
  LBUFFER="${LBUFFER}$(__aws-resource-sel2)"
  local ret=$?
  zle reset-prompt
  return $ret
}




zle     -N   aws-resource-widget
bindkey '^Q' aws-resource-widget

zle     -N   aws-resource-widget2
bindkey '^G' aws-resource-widget2
}
