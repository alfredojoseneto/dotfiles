# Brewfile — ambiente macOS (branch mac)
# Uso: brew bundle --file="$HOME/dotfiles/Brewfile"

# -------------------- BASE ----------------------------------------------------
brew "git"
brew "stow"       # restaura os dotfiles por meio de links simbólicos
brew "zsh"        # shell default (oh-my-zsh é instalado via git clone, ver README)
brew "neovim"     # editor de texto
brew "tmux"       # multiplexador
brew "starship"   # prompt

# -------------------- DEPENDÊNCIAS DO NEOVIM ----------------------------------
brew "ripgrep"    # telescope.nvim (find_files / live_grep)
brew "fd"         # telescope.nvim (find_files)

# -------------------- NODE ----------------------------------------------------
brew "nvm"

# -------------------- PYTHON --------------------------------------------------
brew "pyenv"
brew "pipx"       # poetry, uv, ansible e argcomplete são instalados via pipx
# bibliotecas usadas pelo pyenv para compilar o Python
brew "openssl@3"
brew "readline"
brew "sqlite"
brew "xz"
brew "zlib"
brew "tcl-tk"

# -------------------- CONTAINERS ----------------------------------------------
brew "docker"
brew "docker-compose"
brew "colima"     # runtime de containers (substitui o Docker Desktop)

# -------------------- FONTES E APLICATIVOS ------------------------------------
cask "font-jetbrains-mono-nerd-font"   # fonte usada pelo alacritty.toml
cask "visual-studio-code"
cask "dbeaver-community"
cask "firefox"

# O Alacritty não está aqui: o cask foi desabilitado pelo Homebrew em 2026-09-01
# (não passa no Gatekeeper). A instalação é manual, ver README.
