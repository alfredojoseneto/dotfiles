# Dotfiles — macOS

Roteiro para configurar um mac do zero. Ele foi escrito para ser seguido por uma pessoa ou por um **agent**, na ordem em que aparece.

| Papel | Ferramenta |
| --- | --- |
| Gerenciador de pacotes | Homebrew (`brew bundle` + `Brewfile`) |
| Shell default | zsh + oh-my-zsh |
| Prompt | Starship |
| Terminal | Alacritty |
| Multiplexador | tmux |
| Editor de texto | Neovim (nvim) |
| Restauração das configurações | GNU Stow (links simbólicos) |

## Regras para o agent

1. **Siga as etapas na ordem.** Cada etapa termina com um bloco **Verificação**; só avance quando ele passar.
2. **Todos os comandos são idempotentes.** Podem ser executados de novo sem efeito colateral. Antes de instalar algo, verifique se já existe.
3. **Nunca sobrescreva nem apague um arquivo existente.** Se um arquivo de destino já existir, faça backup com o sufixo `.bak` e avise o usuário.
4. **Antes de cada `stow`, rode a simulação** (`stow -n -v`). Nunca use `stow --adopt`.
5. **Etapas marcadas com [HUMANO]** exigem senha (`sudo`, `chsh`) ou interface gráfica. Não tente executá-las: peça ao usuário e aguarde a confirmação.
6. **Não instale nada por script baixado da internet** (`curl ... | sh`). A única exceção é o instalador oficial do Homebrew, na etapa 1.
7. Todos os comandos funcionam em `bash` ou `zsh` e assumem um mac Apple Silicon (Homebrew em `/opt/homebrew`).

## Visão geral

| Componente | Origem | Pacote stow |
| --- | --- | --- |
| git, stow, zsh, neovim, tmux, starship, ripgrep, fd, nvm, pyenv, pipx, docker, docker-compose, colima | `Brewfile` (fórmulas) | — |
| JetBrainsMono Nerd Font, VS Code, DBeaver, Firefox | `Brewfile` (casks) | — |
| oh-my-zsh, zsh-autosuggestions, fast-syntax-highlighting | `git clone` | — |
| Alacritty | site oficial (manual) | `alacritty` |
| poetry, uv, ansible, argcomplete | `pipx` | — |
| Node.js | `nvm` | — |
| `.zshrc` | — | `zsh` |
| Configuração do nvim | — | `nvim` |
| `.tmux.conf` | — | `tmux` |
| `starship.toml` | — | `starship` |

O que **não** vem do brew, e por quê:

- **Alacritty**: o cask `alacritty` foi desabilitado pelo Homebrew em 2026-09-01, pois o aplicativo não passa na verificação do Gatekeeper.
- **oh-my-zsh**: não existe fórmula no Homebrew. É instalado com `git clone` do repositório oficial.
- **zsh-autosuggestions e fast-syntax-highlighting**: o `.zshrc` carrega os dois pela lista `plugins=(...)`, que exige que estejam em `$ZSH_CUSTOM/plugins`.
- **Plugins do tmux e do nvim**: são baixados pelos próprios gerenciadores (tpm e lazy.nvim).

---

## 1. Pré-requisitos

### 1.1. Xcode Command Line Tools [HUMANO]

```bash
xcode-select -p >/dev/null 2>&1 || xcode-select --install
```

O segundo comando abre uma janela de instalação. Aguarde ela terminar.

### 1.2. Homebrew [HUMANO]

O instalador pede a senha de administrador. Execute apenas se o `brew` ainda não existir.

```bash
command -v brew >/dev/null 2>&1 || [ -x /opt/homebrew/bin/brew ] || \
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# disponibiliza o brew no shell atual
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Nos próximos shells não é preciso repetir o `brew shellenv`: o plugin `brew` do oh-my-zsh, listado no `.zshrc`, faz isso.

**Verificação**

```bash
xcode-select -p    # imprime um caminho
brew --version     # imprime "Homebrew x.y.z"
```

## 2. Clone dos dotfiles

A configuração do mac fica na branch `mac`.

```bash
export DOTFILES="$HOME/dotfiles"
[ -d "$DOTFILES/.git" ] || git clone --branch mac https://github.com/alfredojoseneto/dotfiles.git "$DOTFILES"
```

Se os dotfiles já estiverem clonados em outro diretório, apenas aponte `DOTFILES` para ele. As próximas etapas usam essa variável.

**Verificação**

```bash
git -C "$DOTFILES" branch --show-current   # mac
ls "$DOTFILES/Brewfile"
```

## 3. Instalação dos pacotes (brew bundle)

Todas as fórmulas e casks estão no `Brewfile`. O **stow**, usado na etapa 6, é instalado aqui.

```bash
brew bundle --file="$DOTFILES/Brewfile"
```

**Verificação**

```bash
brew bundle check --file="$DOTFILES/Brewfile" --verbose
# The Brewfile's dependencies are satisfied.
```

## 4. zsh como shell default [HUMANO]

Os dois comandos pedem senha.

```bash
# adição do zsh do Homebrew entre os shells disponíveis
grep -qx "/opt/homebrew/bin/zsh" /etc/shells || echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells

# modificação do shell default
chsh -s /opt/homebrew/bin/zsh
```

**Verificação**

```bash
dscl . -read "$HOME" UserShell   # UserShell: /opt/homebrew/bin/zsh
```

## 5. oh-my-zsh e plugins

O [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) é instalado com `git clone`, sem o script `install.sh`. Assim ele não cria um `~/.zshrc` próprio, que entraria em conflito com o stow.

```bash
# oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# zsh-autosuggestions
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# fast-syntax-highlighting
[ -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] || \
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
```

**Verificação**

```bash
ls "$HOME/.oh-my-zsh/oh-my-zsh.sh"
ls "$HOME/.oh-my-zsh/custom/plugins"   # deve listar zsh-autosuggestions e fast-syntax-highlighting
```

## 6. Restauração das configurações (stow)

Cada diretório do repositório é um pacote do stow e espelha o caminho de destino a partir do `$HOME`.

| Pacote | Link criado |
| --- | --- |
| `zsh` | `~/.zshrc` |
| `nvim` | `~/.config/nvim` |
| `tmux` | `~/.tmux.conf` |
| `starship` | `~/.config/starship` |
| `alacritty` | `~/.config/alacritty` |

```bash
# o ~/.config precisa existir como diretório real;
# sem isso o stow transformaria o próprio ~/.config em um link para o repositório
mkdir -p "$HOME/.config"

cd "$DOTFILES"

# 1) simulação: não altera nada e mostra os conflitos
stow -n -v --target=$HOME zsh nvim tmux starship alacritty
```

Se a simulação acusar conflito (`cannot stow ... over existing target`), o arquivo de destino já existe e não é um link. Faça o backup dele e simule de novo. Exemplo para o `.zshrc`:

```bash
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
```

Com a simulação limpa, crie os links:

```bash
# 2) restauração
stow --target=$HOME zsh
stow --target=$HOME nvim
stow --target=$HOME tmux
stow --target=$HOME starship
stow --target=$HOME alacritty
```

**Verificação**

```bash
ls -l "$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.config/nvim" "$HOME/.config/starship" "$HOME/.config/alacritty"
# todos devem ser links (->) para dentro de $DOTFILES

zsh -n "$HOME/.zshrc" && echo "zshrc ok"
```

Para carregar a nova configuração, abra um novo terminal ou execute `exec zsh`. O `.zshrc` abre o tmux automaticamente (sessão `main`).

## 7. Instalação do NerdFonts

A fonte **JetBrainsMono Nerd Font** é usada pelo `alacritty.toml` e fornece os ícones do Starship, do tmux e do nvim. Ela já faz parte do `Brewfile`; o comando abaixo é o mesmo passo de forma isolada.

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

**Verificação**

```bash
brew list --cask font-jetbrains-mono-nerd-font >/dev/null && echo "fonte ok"
```

## 8. Instalação do Alacritty [HUMANO]

Seguir a instalação do [site do Alacritty](https://alacritty.org/). Como é open source eles não pagam para registrar no site da apple. Por conta disto, precisa sinalizar para o macOS que é não é um software malicioso e que pode sair da quarentena.

```bash
# adição do alacritty às exceções de quarentena do macOS
xattr -rd com.apple.quarantine /Applications/Alacritty.app

# restauração dos dotfiles do alacritty (já feito na etapa 6; repetir não tem efeito)
cd "$DOTFILES"
stow --target=$HOME alacritty
```

**Verificação**

```bash
ls -d /Applications/Alacritty.app
ls -l "$HOME/.config/alacritty"   # link para $DOTFILES/alacritty/.config/alacritty
```

## 9. tmux

Na primeira vez que o tmux abre, o `.tmux.conf` clona o gerenciador de plugins (tpm) em `~/.tmux/plugins/tpm`. Depois disso, instale os plugins.

Dentro do tmux, execute o comando `ctrl + B` depois `Shift + I`. Isso vai ativar o **prefix** e depois instalar as dependências.

Alternativa sem teclado (para agents), com um servidor tmux em execução:

```bash
tmux new-session -d -s setup 2>/dev/null || true
"$HOME/.tmux/plugins/tpm/bin/install_plugins"
tmux kill-session -t setup 2>/dev/null || true
```

**Verificação**

```bash
ls "$HOME/.tmux/plugins"   # tpm, tmux-sensible, vim-tmux-navigator, tmux (tema Dracula)
```

## 10. Neovim

O `init.lua` clona o lazy.nvim na primeira execução. O comando abaixo instala os plugins nas versões fixadas em `lazy-lock.json`, sem abrir a interface.

```bash
nvim --headless "+Lazy! restore" +qa
```

**Verificação**

```bash
ls "$HOME/.local/share/nvim/lazy"
# dracula.nvim, lazy.nvim, lualine.nvim, plenary.nvim, telescope.nvim
```

## 11. Node.js (nvm)

> A instalação do nvm via Homebrew não é suportada oficialmente pelo projeto nvm. Se houver algum problema, compare com o método de instalação padrão antes de reportar.

```bash
# diretório de trabalho do nvm (onde ficam as versões do node)
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"

# carrega o nvm no shell atual; na primeira vez, o script do Homebrew
# também cria os links ~/.nvm/nvm.sh e ~/.nvm/nvm-exec
. "$(brew --prefix nvm)/nvm.sh"

# instalação da versão LTS do node
nvm install --lts
```

Não adicione ao `.zshrc` as linhas sugeridas pelo `brew info nvm`. Ele já exporta `NVM_DIR` e `NVM_HOMEBREW`, e o plugin `nvm` do oh-my-zsh carrega o nvm em modo lazy: só no primeiro uso de `nvm`, `node`, `npm` ou `npx`. O plugin depende do link `~/.nvm/nvm.sh` criado acima.

**Verificação**

```bash
ls -l "$HOME/.nvm/nvm.sh"   # link para /opt/homebrew/opt/nvm/libexec/nvm.sh
node --version
```

## 12. Python (pyenv e pipx)

O **pyenv** gerencia múltiplas versões do Python sem comprometer a versão do sistema. O **pipx** instala ferramentas Python em ambientes isolados. Todas as ferramentas Python são instaladas via pipx.

```bash
# instalação de uma versão do Python (ajuste a versão desejada)
PYTHON_VERSION=3.14
pyenv install --skip-existing "$PYTHON_VERSION"
pyenv global "$(pyenv latest "$PYTHON_VERSION")"

# ferramentas Python
pipx install argcomplete              # autocomplete do pipx no zsh
pipx install poetry
pipx install uv
pipx install --include-deps ansible

# configuração do poetry
poetry config virtualenvs.in-project true
poetry config virtualenvs.use-poetry-python true
```

O pipx instala os executáveis em `~/.local/bin`, que o `.zshrc` já coloca no `PATH`. Em um shell sem o `.zshrc`, execute `export PATH="$HOME/.local/bin:$PATH"` antes dos comandos `poetry`.

**Verificação**

```bash
pyenv versions
pipx list --short            # argcomplete, poetry, uv, ansible
poetry config --list | grep virtualenvs.in-project   # true
```

## 13. Docker (Colima)

O **Colima** é o runtime de containers, no lugar do Docker Desktop. As fórmulas `docker`, `docker-compose` e `colima` já foram instaladas pelo `Brewfile`.

```bash
colima status >/dev/null 2>&1 || colima start
```

Para o subcomando `docker compose` (com espaço) funcionar, o Docker precisa saber onde o Homebrew instala os plugins. Adicione a chave abaixo ao `~/.docker/config.json`, **mesclando** com o conteúdo existente, sem substituir o arquivo:

```json
{
  "cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]
}
```

**Verificação**

```bash
docker run --rm hello-world
docker compose version
```

## 14. Configuração do git-adog

```bash
git config --global alias.adog "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
```

**Verificação**

```bash
git config --global --get alias.adog   # imprime o alias
```

## 15. Verificação final

```bash
brew bundle check --file="$DOTFILES/Brewfile"          # dependencies are satisfied
dscl . -read "$HOME" UserShell                         # /opt/homebrew/bin/zsh
ls -l "$HOME/.zshrc" "$HOME/.tmux.conf" \
      "$HOME/.config/nvim" "$HOME/.config/starship" \
      "$HOME/.config/alacritty"                        # todos são links para $DOTFILES
zsh -n "$HOME/.zshrc" && echo "zshrc ok"
starship --version
tmux -V
nvim --version | head -1
ls "$HOME/.tmux/plugins" "$HOME/.local/share/nvim/lazy"
pipx list --short
docker version --format '{{.Server.Version}}'
```

O teste definitivo é do usuário: abrir o Alacritty e conferir se o tmux inicia na sessão `main`, se o prompt do Starship aparece com os ícones e se o nvim abre com o tema Dracula.

---

## O que o .zshrc configura

O `.zshrc` do pacote `zsh` já contém toda a configuração do shell. Não adicione linhas a ele com `echo ... | tee -a ~/.zshrc`.

- **Tema**: `ZSH_THEME=""`, pois o prompt é do **Starship**, iniciado no fim do arquivo.
- **Plugins**: a lista fica em `plugins=(...)`. O `fast-syntax-highlighting` precisa ser sempre o último.
- **Homebrew**: o plugin `brew` executa o `brew shellenv`, que coloca `/opt/homebrew/bin` no `PATH`.
- **tmux**: o plugin `tmux` cria a sessão `main` ou se conecta a ela ao abrir o terminal (exceto no terminal do VS Code).
- **nvm**: `NVM_DIR` e `NVM_HOMEBREW` exportados; carregamento lazy pelo plugin `nvm`.
- **ssh-agent**: carrega a chave `~/.ssh/id_ed25519` ao iniciar.
- **pipx**: autocomplete ativado quando o `argcomplete` está instalado.
- **compinit**: executado pelo próprio oh-my-zsh, não precisa ser chamado de novo.
- **`~/.zshrc.local`**: se existir, é carregado no final. Use para ajustes e segredos específicos da máquina, pois ele fica fora do git.

## Outros arquivos do repositório

- `vim/.vimrc`: configuração antiga do vim, mantida como referência. Não faz parte deste roteiro.
- `dockerfiles/` e `vagrant/`: ambientes de desenvolvimento auxiliares, sem relação com a configuração do mac.
