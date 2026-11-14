# =============================================================================
# -------------------- ENVIRONMENT --------------------------------------------
# =============================================================================
# typeset -U keeps PATH free of duplicates when the file is sourced again
typeset -U path PATH
path=("$HOME/.local/bin" $path)   # pipx, poetry

export EDITOR="nvim"
export VISUAL="$EDITOR"
[[ -z "$LANG" ]] && export LANG="en_US.UTF-8"

# nvm installed via Homebrew (see README):
#   NVM_DIR     -> where node versions live (outside the Cellar, survives upgrades)
#   NVM_HOMEBREW -> where the nvm plugin finds the completion shipped by brew
export NVM_DIR="$HOME/.nvm"
export NVM_HOMEBREW="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/nvm"

# =============================================================================
# -------------------- OH-MY-ZSH ----------------------------------------------
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

# The prompt is handled by Starship (see the end of this file)
ZSH_THEME=""

# Just remind me to update when it's time
zstyle ':omz:update' mode reminder

# nvm: load only on the first use of node/npm/npx/nvm (faster startup)
zstyle ':omz:plugins:nvm' lazy yes

# ssh-agent: identities loaded when the agent starts
zstyle ':omz:plugins:ssh-agent' identities id_ed25519
zstyle ':omz:plugins:ssh-agent' quiet yes

# tmux: create session 'main' or attach to it if it already exists
ZSH_TMUX_DEFAULT_SESSION_NAME="main"
ZSH_TMUX_AUTOQUIT=false
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  ZSH_TMUX_AUTOSTART=true
fi

# Custom plugins (installed in $ZSH_CUSTOM/plugins, see README):
#   zsh-autosuggestions, fast-syntax-highlighting
plugins=(
  brew
  ansible
  docker
  docker-compose
  dotenv
  extract
  git
  man
  nvm
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
  # zsh-syntax-highlighting
  fast-syntax-highlighting   # must be the last plugin
)

# oh-my-zsh already runs compinit, no need to call it again
source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# -------------------- COMPLETIONS --------------------------------------------
# =============================================================================
if command -v register-python-argcomplete >/dev/null 2>&1; then
  eval "$(register-python-argcomplete pipx)"
fi

# =============================================================================
# -------------------- SDKMAN -------------------------------------------------
# =============================================================================
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# =============================================================================
# -------------------- STARSHIP -----------------------------------------------
# =============================================================================
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"
fi

# =============================================================================
# -------------------- LOCAL OVERRIDES ----------------------------------------
# =============================================================================
# Machine-specific settings and secrets, kept out of git
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
