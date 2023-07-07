brewfiles := $(shell ls ./brew)

.PHONY: all install init brew brewlink dotfiles sync revert_brew revert_dotfiles
all: install

install: init brew brewlink dotfiles
	@neofetch
	@echo "Don't forget to download a powerline font if you want it\!"

init:
	# installing homebrew
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# installing zsh
	@brew install zsh

	# installing oh-my-zsh
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	# installing zinit
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

	# installing other common brew packages
	brew install fasd fzf gcc git howdoi httpie lsd neofetch openssl pipeline \
	python the_silver_searcher tmux wget zsh-syntax-highlighting

brew:
	# copying custom brew scripts to /usr/local/lib/brew
	@mkdir -p /usr/local/lib/brew
	@mkdir -p backups/brew
	@rm -rf backups/brew/*
	@cp /usr/local/lib/brew/* backups/brew
	@rm -rf /usr/local/lib/brew/*
	@cp brew/* /usr/local/lib/brew
	@echo "Copied: $(brewfiles)"

brewlink:
	# linking custom brew files into /usr/local/bin
	@$(foreach cmd,$(brewfiles),ln -s /usr/local/lib/brew/$(cmd) /usr/local/bin/$(cmd) > /dev/null 2>&1 && echo "Linking $(cmd)" || echo "$(cmd) already linked; skipping")

dotfiles:
	@mkdir -p backups/dotfiles
	# copying zsh dotfiles
	@cp $$HOME/.zshrc backups/dotfiles/zshrc.bak
	@cp $$HOME/.zprofile backups/dotfiles/zprofile.bak
	@cp dotfiles/.zshrc $$HOME
	@cp dotfiles/.zprofile $$HOME

	# copying vim dotfiles
	@cp $$HOME/.vimrc backups/dotfiles/vimrc.bak
	@cp dotfiles/.vimrc $$HOME

	# copying git dotfiles
	@cp $$HOME/.gitconfig backups/dotfiles/gitconfig.bak
	@cp $$HOME/.gitignore_global backups/dotfiles/gitignore_global.bak
	@cp dotfiles/.gitconfig $$HOME
	@cp dotfiles/.gitignore_global $$HOME

sync:
	# cleaning brew dir and collecting system files
	@rm -rf brew/*
	@cp /usr/local/lib/brew/* brew

	# cleaning dotfiles and collecting system files
	@rm -rf dotfiles/*
	@cp $$HOME/.zshrc dotfiles || echo > /dev/null
	@cp $$HOME/.zprofile dotfiles || echo > /dev/null
	@cp $$HOME/.vimrc dotfiles || echo > /dev/null
	@cp $$HOME/.gitconfig dotfiles || echo > /dev/null
	@cp $$HOME/.gitignore_global dotfiles || echo > /dev/null

revert_dotfiles:
	# reverting to old dotfiles (if any)
	@cp backups/dotfiles/zshrc.bak $$HOME/.zshrc || echo > /dev/null
	@cp backups/dotfiles/zprofile.bak $$HOME/.zprofile || echo > /dev/null
	@cp backups/dotfiles/vimrc.bak $$HOME/.vimrc || echo > /dev/null
	@cp backups/dotfiles/gitconfig.bak $$HOME/.gitconfig || echo > /dev/null
	@cp backups/dotfiles/gitignore_global.bak $$HOME/.gitignore_global || echo > /dev/null

revert_brew:
	# reverting to old custom brew commandsd (if any)
	@rm -rf /usr/local/lib/brew/*
	@cp backups/brew/* /usr/local/lib/brew || echo > /dev/null
