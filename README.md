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

Para mudar a cor default dos diretórios no KDE
Os ícones que utilizo são "Tela Dracula Dark"
```text
Settings >> Apps& & Windows >> Default Applications >> File Associations >> inode >> directory

Depois, só selecionar a folder default.
```

Configuração do hd [link](https://forums.linuxmint.com/viewtopic.php?t=335231)
```bash
# primeiro criar o diretório onde será montado o arquivo
$ sudo mount /media/hd

# identificar o UUID do HD e como ele está sendo identificado no /dev/sdX
$ sudo blkid
$ lsblk

# criar o backup do /etc/fstab
$ sudo cp /etc/fstab /etc/fstab.bak

# editar o /etc/fstab
$ sudo vim /etc/fstab

# essa linha é um exemplo para adição
UUID=0074352B74352536   /media/hd       ntfs    defaults,uid=1000,gid=1000,noatime       0       2

# atualizar o daemon após a modificação
$ sudo systemctl daemon-reload

# montagem do dispositivo
$ sudo mount -a

```

