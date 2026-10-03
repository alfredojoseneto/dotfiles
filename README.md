# Dotfiles

### Instalação e Configuração do ZSH e configuração do oh-my-zsh
Primeiramente iremos instalar o zsh e trocar para o zsh como default shell

```bash
# instalação do zsh e syntax highlight
sudo apt install zsh

# modificação do shell par ao zsh
chsh -s $(which zsh)
```

### Instalação do Stow + Clone dos Dotfiles

O **stow** vai permitir restaurar adequadamente todas as configurações dos **dotfiles**

```bash
# instalação do stow
sudo apt install stow

# clone dos dotfiles
mkdir ~/dotfiles
git clone https://github.com/alfredojoseneto/dotfiles.git ~/dotfiles
```

### Instalação e configuração do ZSH, oh-my-zsh

```bash
# instalação do oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# instalação do autossugestion
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# instalação do syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# instalação do zsh-fast-syntax-highlight
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# instalação do zsh-fast-syntax-highlight
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# adidicona as importações do autocomplete, syntax highlight e fast-syntax-high-light
echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh' | tee -a ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh' | tee -a ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' | tee -a ~/.zshrc
```

Aqui se encontram os plugins a serem utilizados. Procure por `plugins` e troque pelas linhas abaixo.

```bash
plugins=(
 ansible
 docker
 docker-compose
 dotenv
 extract
 git
 man
 poetry
 pyenv
 python
 ssh
 ssh-agent
 sudo
 tmux
 uv
 vscode
 zsh-autosuggestions
 zsh-syntax-highlighting
 fast-syntax-highlighting
)
```

### Instalação do Starship
O **Starship** é uma customização para o shell para deixar ele mais elegante.

```bash
# instalação
curl -sS https://starship.rs/install.sh | sh

# adicionando as configurações por meio do stow
cd dotfiles
stow --target=$HOME starship

# adicionando as configurações
echo 'export STARSHIP_CONFIG=~/.config/starship/starship.toml' | tee -a ~/.zshrc
echo 'eval "$(starship init zsh)"' | tee -a ~/.zshrc
```

[Here](https://starship.rs/presets/nerd-font) are a lot of symbols that you can use. You can find

### Instalação do NerdFonts

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### Configuração do git-adog

<<<<<<< HEAD
### Instalação do desktop-file-utils
Importante para a instalação do alacritty

```bash
sudo apt install desktop-file-util`
```

### Resolução do problema da internet e do bluetooh

```bash
# identificando qual o nome da placa de rede e do bluetooth
lspci -k | grep -A3 -i network
lsmod | grep rtl

# instalação do firmware
sudo apt install firmware-iwlwifi

# atualizando o initramfs
sudo update-initramfs -u

# atualizando as informações para o tipo de placa de rede
sudo echo "options ath9k nohwcrypt=1" | sudo tee  /etc/modprobe.d/ath9k.conf
sudo echo "options ath9k power_save=0" | sudo tee  /etc/modprobe.d/ath9k.conf
sudo echo "options ath9k power_schema=1" | sudo tee  /etc/modprobe.d/ath9k.conf
sudo echo -e "[connection]\nwifi.powersave = 2" | sudo tee /etc/NetworkManager/conf.d/wifi-powersave.conf

# criação do arquivo com as configurações do bluetooth
sudo echo 'ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="04ca", ATTR{idProduct}=="3014", ATTR{power/autosuspend}="-1"' | sudo tee /etc/udev/rules.d/50-usb_power_save.rules

# atualizando as informações da placa no kernel
sudo rmmod ath9k
sudo modprobe ath9k
sudo systemctl restart NetworkManager
```

### Resolução do problema do bluetooth que está com o plugin inadequado
```bash
# irá remover o plugin que está competindo com o Pipewire
sudo apt purge -y bluez-alsa-utils
```

### Instalação do alacritty

Seguir a orientação do [link](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#prerequisites) do GitHub do Alacritty.

### Instalação do Docker, Neovim, LazyVim e do Dracula Theme

- [Docker][https://docs.docker.com/engine/install/debian/]
- [Nvim](https://github.com/neovim/neovim)
- [LazyVim](https://www.lazyvim.org/)
- [Dracula Theme for LazyVim](https://github.com/Mofiqul/dracula.nvim)


### Instalação dos Dotfiles


```bash
sudo apt install stow
```

Clone the github repository and use the commands below to set the target folder

```bash
stow --target=/home/$USER/ <package>

# example  ---------------------------------------------------------------------
stow --target=/home/$USER/ nvim
stow -t ~ alacritty
```

### Configuração do git "adog"
=======
>>>>>>> mac
```bash
git config --global alias.adog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
```

### Instalação do Alacritty

Seguir a instalação do [site do Alacritty](https://alacritty.org/). Como é open source eles não pagam para registrar no site da apple. Por conta disto, precisa sinalizar para o macOS que é não é um software malicioso e que pode sair da quarentena.

```bash
# adição do alacritty às exceções de quarentena do macOS
xattr -rd com.apple.quarantine /Applications/Alacritty.app

# restauração dos dotfiles do alacritty
cd ~/dotfiles
stow --target=$HOME alacritty
```

### Instalação do tmux

Após instalar o tmux, restaurar os **dotfiles** e inserir as instruções no arquivo **.zshrc**. Abra o terminal e execute o comando `ctrl + B` depois `Shift + I`. Isso vai ativar o **prefix** e depois instalar as dependências.

```bash
# instalação do tmux
brew install tmux

# instalação das configurações do tmux
cd ~/dotfiles
stow --target=$HOME tmux

echo '
# =============================================================================
# -------------------- STARTING TMUX WHEN OPEN TERMINAL -----------------------
# =============================================================================
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
fi
' | tee -a ~/.zshrc
```

### Instalação do Starship
O **Starship** é uma customização para o shell para deixar ele mais elegante.

```bash
# instalação
curl -sS https://starship.rs/install.sh | sh

# adicionando as configurações por meio do stow
cd ~/dotfiles
stow --target=$HOME starship

# adicionando as configurações
echo 'export STARSHIP_CONFIG=~/.config/starship/starship.toml' | tee -a ~/.zshrc
echo 'eval "$(starship init zsh)"' | tee -a ~/.zshrc
```


### Instalação do Dracula Theme para o VIM

```bash
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
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
sudo apt install pipx
sudo pipx ensurepath --global --force
```

#### 2.1.1.instalação do autocomplete

```bash
pipx install argcomplete
echo 'eval "$(register-python-argcomplete pipx)"' | tee -a ~/.zshrc
```

#### 3.poetry
Seguir a orientação da documentação oficial do poetry para instalação via pipx [link](https://python-poetry.org/docs/#installing-with-pipx).
O objetivo do **poetry** é permitir gerenciar projetos python de uma maneira muito mais organizada.

```bash
pipx install poetry
source ~/.bashrc
```

#### 3.1.configuração do poetry
Após a instalação do **poetry** é importante executar algumas configurações para que ele possa ser utilizado de uma melhor maneira, em especial com o VSCode.
Além de permitir o code completion para o bash.

```bash
poetry completions bash >> ~/.bash_completion/poetry
echo "\n#poetry completions" >> ~/.bashrc
echo "source ~/.bash_completion/poetry" >> ~/.bashrc
poetry config --list
poetry config virtualenvs.in-project true
poetry config virtualenvs.use-poetry-python true
```

### Configuração das Fontes com o Lucid Glyph (ClearType)
Segue as orientações nesse [link](https://github.com/maximilionus/lucidglyph)


### Instalação do SDK Man
Basta seguir as orientaçãoes do repositório [link](https://sdkman.io/install/)

```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 25-open
```

### Instalação do [nvm](https://github.com/nvm-sh/nvm)
Instalação do nvm para gerenciamento das versões do node.js.


### Instalação do DBeaver

```bash
sudo  wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt-get update && sudo apt-get install dbeaver-ce
```

### Modernize APT Sources

```bash
sudo apt modernize-sources
```

### Ajuste no IBus

Esse é um processo para corrigir os avisos constantes do IBus [link](https://discuss.kde.org/t/ibus-issue-with-wayland/3680/14)

```bash
sudo apt install -y zenity
im-config
```
Depois do "im-config", seguir a seguinte ordem: OK -> YES > do not activate any IM from im-config and use desktop default -> OK -> reboot
As variávies de ambiente não serão mais "setadas" e com isso os warnings não serão mais apresentados.

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
