all: install

install: dotfiles pipeline
	@neofetch

apt:
	# update APT repos and install basic tools
	@apt-get -y update
	@apt-get -y install curl gcc git howdoi httpie libreadline-dev libncurses-dev \
	neofetch openssl python tmux vim wget zsh

dotfiles: zsh
	# copy dotfiles to appropriate locations
	@cp dotfiles/vim/.vimrc $$HOME
	@cp dotfiles/zsh/.zshrc $$HOME
	@cp dotfiles/zsh/custom/* $$HOME/.oh-my-zsh/custom

pipeline: apt
	# install the `pipeline` utility
	@wget https://github.com/codekitchen/pipeline/releases/download/v1.5/pipeline-1.5.tar.gz
	@tar -zxf ./pipeline-1.5.tar.gz
	@pushd pipeline-1.5 && ./configure && make install && popd

zsh: apt
	# install oh-my-zsh
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	
	# install zinit
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

