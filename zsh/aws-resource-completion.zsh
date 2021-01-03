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

__aws-resource-sel() {
  local cache_dir="${XDG_CACHE_DIR:-${HOME}/.cache}"
  local cmd="cat ${cache_dir}/aws-resources"

  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

aws-resource-widget() {
  LBUFFER="${LBUFFER}$(__aws-resource-sel)"
  local ret=$?
  zle reset-prompt
  return $ret
}


zle     -N   aws-resource-widget
bindkey '^Q' aws-resource-widget

}
