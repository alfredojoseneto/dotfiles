# Dotfiles


```bash
$ sudo apt install stow
```

Clone the github repository and use the commands below to set the target folder

```bash
$ stow --target=/home/$USER/ <package>

# example  ---------------------------------------------------------------------
$ stow --target=/home/$USER/ nvim
$ stow -t ~ alacritty
```

Configuração do git "adog"
```bash
$ git config --global alias.adog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
```

