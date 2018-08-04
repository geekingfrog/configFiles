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

# Termite
```bash
ln -s ${PWD}/termite_config ${XDG_CONFIG:-$HOME/.config}/termite/config
```

# Git
Symlink .gitconfig or copy paste the useful stuff inside.
