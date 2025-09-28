# Dotfiles

### Instalação dos Dotfiles


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

### Configuração do git "adog"
```bash
$ git config --global alias.adog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
```

### Mudar a cor default dos diretórios no KDE

Os ícones que utilizo são "Tela Dracula Dark"
```text
Settings >> Apps& & Windows >> Default Applications >> File Associations >> inode >> directory

Depois, só selecionar a folder default.
```

### Configuração do hd [link](https://forums.linuxmint.com/viewtopic.php?t=335231)
```bash
# primeiro criar o diretório onde será montado o arquivo
$ sudo mkdir -p /media/hd

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

### Configuração do pyenv, pipx e poetry

Seguir esta sequência de instalação: pyenv >> pipx >> poetry

#### 1.pyenv
Seguir a orientação do repositório do github do pyenv [link](https://github.com/pyenv/pyenv).
O objetivo do **pyenv** é poder gerenciar múltiplas versões do Python sem comprometer a versão do sistema.

#### 2.pipx
Seguir a orientação da documentação oficial do pipx [link](https://pipx.pypa.io/stable/installation/)
O objetivo do **pipx** é poder instalar pacotes python, como o **poetry** em ambientes isolados e não impactar nos outros pacotes do sistema.

#### 2.1.pipx configuration

Instalação do pipx

```bash
$ sudo apt update
$ sudo apt install pipx
$ sudo pipx ensurepath --global --force
```

#### 2.1.1.instalação do autocomplete

```bash
$ pipx install argcomplete
$ echo 'eval "$(register-python-argcomplete pipx)"' >> ~/.bashrc
```

#### 3.poetry
Seguir a orientação da documentação oficial do poetry para instalação via pipx [link](https://python-poetry.org/docs/#installing-with-pipx).
O objetivo do **poetry** é permitir gerenciar projetos python de uma maneira muito mais organizada.

```bash
$ pipx install poetry
$ source ~/.bashrc
```

#### 3.1.configuração do poetry
Após a instalação do **poetry** é importante executar algumas configurações para que ele possa ser utilizado de uma melhor maneira, em especial com o VSCode.
Além de permitir o code completion para o bash.

```bash
$ poetry completions bash >> ~/.bash_completion/poetry
$ echo "\n#poetry completions" >> ~/.bashrc
$ echo "source ~/.bash_completion/poetry" >> ~/.bashrc
$ poetry config --list
$ poetry config virtualenvs.in-project true
$ poetry config virtualenvs.use-poetry-python true
```

### Configuração das Fontes com o Lucid Glyph (ClearType)
Segue as orientações nesse [link](https://github.com/maximilionus/lucidglyph)


### Instalação do SDK Man
Basta seguir as orientaçãoes do repositório [link](https://sdkman.io/install/)

```bash
$ curl -s "https://get.sdkman.io" | bash
$ source "$HOME/.sdkman/bin/sdkman-init.sh"
$ sdk install java 25-open
```

### Instalação do DBeaver

```bash
$ sudo  wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
$ echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
$ sudo apt-get update && sudo apt-get install dbeaver-ce
```

### Modernize APT Sources

```bash
$ sudo apt modernize-sources
```

### Configuração do PS1 Bash
Utilizar o PS1.text, mas há esses três links com informações complementares, caso deseje mudar algo
[link-1](https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-bash-ps1-prompt)
[link-2](https://wiki.archlinux.org/title/Bash/Prompt_customization)
[link-3](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors)

```text
# =============================================================================
# -------------------- STARTING TMUX WHEN OPEN TERMINAL -----------------------
# =============================================================================
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
fi


#==============================================================================
#-------------------- PS1 BASH ------------------------------------------------
#==============================================================================

# Colors
FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_LIGHT_CYAN="\[\e[96m\]"
FG_GREEN="\[\e[32m\]"
FG_LIGHT_GREEN="\[\e[92m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_YELLOW="\[\e[33m\]"
FG_LIGHT_YELLOW="\[\e[93m\]"
FG_WHITE="\[\e[97m\]"
FG_PURPLE="\[\033[1;35m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_MAGENTA="\[\e[45m\]"
BG_RED="\[\e[41m\]"
STARTLINE="\342\224\214\342\224\200"
ENDLINE="\342\224\224\342\224\200\342\224\200\342\225\274"

parse_git_bg() {
	[[ $(git status -s 2> /dev/null) ]] && echo -e "\e[43m" || echo -e "\e[42m"
}

parse_git_fg() {
	[[ $(git status -s 2> /dev/null) ]] && echo -e "\e[93m" || echo -e "\e[92m"
}

# Python Version
python_version(){
    if [[ -n $(python3 --version)  ]]
    then
        python3 --version | awk '{print $2 }'
    fi
}

PS1=""
PS1="\n${FG_CYAN}$STARTLINE${FMT_RESET}" # begin arrow to prompt
PS1+="[${FMT_BOLD}${FG_YELLOW} \$(python_version)${FMT_RESET}-${FMT_BOLD}${FG_GREEN}\u${FMT_RESET}${FMT_BOLD}${FG_WHITE}@${FMT_RESET}${FMT_BOLD}${FG_PURPLE}\h${FMT_RESET}]-[${FMT_BOLD}${FG_CYAN}\W${FMT_RESET}]"
PS1+="${FMT_RESET}"
PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
PS1+="-[${FMT_BOLD}\$(parse_git_fg) BRANCH${FMT_RESET}]" # print current git branch
PS1+="${FMT_RESET}\$(parse_git_fg)\")${FMT_RESET}\n" # end last container (either FILES or BRANCH)
PS1+="${FG_CYAN}$ENDLINE " # end arrow to prompt
PS1+="${FG_CYAN}\\$ " # print prompt
PS1+="${FMT_RESET}"
export PS1

#==============================================================================
```
