# Zsh
```bash
ln -s .zshrc ~/
ln -s geekingfrog.zsh ~/.oh-my-zsh/custom
```

# i3
Requires `i3wm` and [i3status-rust](https://github.com/greshake/i3status-rust)

```bash
mkdir -p ${XDG_CONFIG:-$HOME/.config}/i3
ln -s ${PWD}/i3/desktop_config ${XDG_CONFIG:-$HOME/.config}/i3/config
ln -s ${PWD}/i3/desktop_status.toml ${XDG_CONFIG:-$HOME/.config}/i3/status.toml
```

# Term
`make term_config`

# Git
Symlink .gitconfig or copy paste the useful stuff inside.

# Rofimoji extra
`mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/rofimoji/data" && cp emojis_smileys_emotion.additional.csv ${XDG_DATA_HOME:-$HOME/.local/share}/rofimoji/data/`
