# vim:noexpandtab ts=4 sw=4

CONFIG_HOME := $(or $(XDG_CONFIG_HOME), $(HOME)/.config)

stuff:
	echo $(CONFIG_HOME)

laptop: general i3_config_laptop zsh_config_perso

desktop: general i3_config_desktop zsh_config_perso

general: git_config term_config haskell_config nvim_config

git_config:
	./gitconfig

term_config:
	mkdir -p $(CONFIG_HOME)/termite
	ln -sf ${PWD}/termite_config $(CONFIG_HOME)/termite/config

# need oh-my-zsh installed: https://github.com/robbyrussell/oh-my-zsh
# curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
# sh install.sh
# The theme needs: https://github.com/romkatv/powerlevel10k
zsh_config_perso:
	cat ${PWD}/zsh/base.zsh ${PWD}/zsh/plugins_desktop.zsh ${PWD}/zsh/user_config.zsh > $(HOME)/.zshrc
	cp ${PWD}/zsh/p10k-lean.zsh $(HOME)

haskell_config:
	ln -sf ${PWD}/.ghci $(HOME)/.ghci
	ln -sf ${PWD}/.haskeline $(HOME)/.haskeline

########################################
# Neovim

NVIM_CONFIG_HOME := $(CONFIG_HOME)/nvim

nvim_config:
	mkdir -p $(NVIM_CONFIG_HOME)
	ln -sf $(PWD)/vim/init.vim $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/codeEditting.vimrc $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/completion.vimrc $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/general.vimrc $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/keys.vimrc $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/plugins.vimrc $(NVIM_CONFIG_HOME)/
	ln -sf $(PWD)/vim/theming.vimrc $(NVIM_CONFIG_HOME)/


########################################
# I3

I3_CONFIG_HOME := $(CONFIG_HOME)/i3
I3_CONFIG_FILE := $(I3_CONFIG_HOME)/config

i3_config_general:
	mkdir -p $(I3_CONFIG_HOME)
	cat i3/base_config > $(I3_CONFIG_FILE)

i3_config_laptop: i3_config_general
	cat i3/laptop_config >> $(I3_CONFIG_FILE)
	ln -sf $(PWD)/i3/laptop_status.toml $(I3_CONFIG_HOME)/status.toml

i3_config_desktop: i3_config_general
	cat i3/desktop_config >> $(I3_CONFIG_FILE)
	ln -sf $(PWD)/i3/desktop_status.toml $(I3_CONFIG_HOME)/status.toml
