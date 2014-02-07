# Vim
my `.vimrc`, and some snippets files to be used with UltiSnips.
`ln -s .vimrc ~/`

# Zsh
```bash
ln -s .zshrc ~/
ln -s geekingfrog.zsh ~/.oh-my-zsh/custom
```

# Awesome
```bash
mkdir -p ~/.config/awesome
ln -s rc.lua ~/.config/awesome/

```

# Urxvt
```bash
ln -s .Xdefaults ~/
sudo ln -s urxvt/perl/* /usr/lib/urxvt/perl/
```

# Git
A few configuration to manually add to ~/.gitconfig

```
[color]
  ui = true
[core]
  editor = vim
[alias]
  st = status -sb
  co = checkout
  br = branch
[merge]
  tool = meld
[mergetool]
  keepBackup = false
[push]
  default = upstream
[branch]
  autosetuprebase = always
[pull]
  rebase = preserve
```
