all: install

install: dotfiles

dotfiles: zsh
	# link dotfile to appropriate locations
	@ln -s $(pwd)dotfiles/vim/.vimrc $$HOME
	@ln -s $(pwd)dotfiles/nvim $$HOME/.config/nvim
	@ln -s $(pwd)dotfiles/zsh/.zshrc $$HOME
	@ln -s $(pwd)dotfiles/oh-my-zsh/aliases.zsh $$HOME/.oh-my-zsh/custom/aliases.zsh

zsh: yum
	# install oh-my-zsh
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# install zinit
	@bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

yum:
	# update repos and install basic tools
	@yum -y update
	@yum -y upgrade
	@yum -y install gcc git neovim zsh
