# Genesis
Bootstrap a new development environment.

# Usage

```
make init # install homebrew, zsh, oh-my-zsh, zinit, and other CLI tools.
make brew # install custom  homebrew commands callable with `brew cmd`
make dotfiles # install dotfiles for zsh, vim, and git into $HOME
make install # run all of the above to provision from scratch
make sync # sync the repo with brew commands and dotfiles on the system
make revert_brew # restore old custom brew commands
make revert_dotfiles # restore old dotfile versions
make brewlink # link all custom brew commands into /usr/local/bin
```
