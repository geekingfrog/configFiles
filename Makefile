# vim:noexpandtab ts=4 sw=4

CONFIG_HOME := $(or $(XDG_CONFIG_HOME), $(HOME)/.config)

laptop: general i3_config_laptop zsh_config_perso

desktop: general i3_config_desktop zsh_config_perso

general: git_config term_config haskell_config nvim_config

server: git_config nvim_config zsh_config_perso

git_config:
	./gitconfig

term_config:
	mkdir -p $(CONFIG_HOME)/alacritty/
	ln -sf ${PWD}/alacritty.toml $(CONFIG_HOME)/alacritty/alacritty.toml


# need oh-my-zsh installed: https://github.com/robbyrussell/oh-my-zsh
# curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
# sh install.sh
# The theme needs: https://github.com/romkatv/powerlevel10k
zsh_config_perso:
	cat ${PWD}/zsh/base.zsh ${PWD}/zsh/plugins.zsh ${PWD}/zsh/user_config.zsh > $(HOME)/.zshrc
	cp ${PWD}/zsh/geekingfrog.zsh $(HOME)/.oh-my-zsh/custom
	cp ${PWD}/zsh/p10k-lean.zsh $(HOME)
	cp ${PWD}/zsh/omnifzf.zsh $(HOME)/.oh-my-zsh/custom
	mkdir -p $(HOME)/.local/bin/
	ln -sf ${PWD}/scripts/shot $(HOME)/.local/bin/

haskell_config:
	ln -sf ${PWD}/.ghci $(HOME)/.ghci
	ln -sf ${PWD}/.haskeline $(HOME)/.haskeline

########################################
# Neovim

nvim_config:
	ln -sf $(PWD)/vim $(CONFIG_HOME)/nvim


########################################
# I3

I3_CONFIG_HOME := $(CONFIG_HOME)/i3
I3_CONFIG_FILE := $(I3_CONFIG_HOME)/config

i3_config_general:
	mkdir -p $(I3_CONFIG_HOME)
	cat i3/base_config > $(I3_CONFIG_FILE)
	mkdir -p $(HOME)/.local/bin/
	ln -sf $(PWD)/i3/get_music_info $(HOME)/.local/bin/

i3_config_laptop: i3_config_general
	cat i3/laptop_config >> $(I3_CONFIG_FILE)
	ln -sf $(PWD)/i3/laptop_status.toml $(I3_CONFIG_HOME)/status.toml

i3_config_desktop: i3_config_general
	cat i3/desktop_config >> $(I3_CONFIG_FILE)
	ln -sf $(PWD)/i3/desktop_status.toml $(I3_CONFIG_HOME)/status.toml

# to be used for brand new system without i3status-rust
i3_config_bare: i3_config_general
	cat i3/bare_config >> $(I3_CONFIG_FILE)
	ln -rf $(PWD)/i3/bare_status.conf $(I3_CONFIG_HOME)/status.conf
