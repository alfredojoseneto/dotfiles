# Setting the default image
ARG BASE_IMAGE=debian:bookworm-slim

FROM ${BASE_IMAGE}

# Default pyhton and node versions
ENV PYTHON_VERSION="3.12.0"
ENV NODE_VERSION="lts/iron"

# Setting the default user
ARG DEFAULT_USER=default_user
ARG UID=1000
ARG GID=1000

# Setting some environment variables
ENV SHELL=/bin/bash

# Starting the installation process as root user
USER root

# Dependencies to be installed
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt upgrade -y && \
    apt install -y \
    curl \
    git \
    sed \
    sudo \
    wget \
    # Python build dependencies for pyenv
    build-essential \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    tk-dev \
    xz-utils \
    zlib1g-dev \
    # Neovim dependencies
    fd-find \
    ninja-build \
    gettext \
    cmake \
    npm \
    ripgrep \
    unzip
    # curl  # already installed

# Creating user group
RUN groupadd --non-unique --gid ${GID} ${DEFAULT_USER}

# Creating the user
RUN useradd --non-unique --create-home --uid ${UID} --gid ${GID} ${DEFAULT_USER}

# Adding user into sudo
RUN usermod -aG sudo ${DEFAULT_USER}

# Adjusting sudoers permissions
RUN sed -i /etc/sudoers \
    -re 's/root.*/root ALL=(ALL:ALL) NOPASSWD:ALL/g' \
    -re 's/%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g' \
    -re 's_@includir.*_#### Removed @includir ####_'

# Switch for default user
USER ${DEFAULT_USER}

# Default shell
ENV SHELL=/bin/bash

# Installing pyenv
RUN curl https://pyenv.run | bash

# Adjusting pyenv environment variables
ENV PYENV_ROOT=/home/${DEFAULT_USER}/.pyenv
ENV PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH

# Installing python version
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}

# Installing poetry and configuring it
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    export PATH="$HOME/.local/bin:$PATH" && \
    poetry config virtualenvs.in-project true && \
    poetry config virtualenvs.prefer-active-python true

# Adjusting environment to contamplate poetry installation
ENV PATH="/home/${DEFAULT_USER}/.local/bin:$PATH"

# Installing nvm to manage node versions
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    . $NVM_DIR/nvm.sh && \
    nvm ls-remote --lts && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION} && \
    nvm use default

# Installing Neovim
RUN cd /tmp && \
    git clone https://github.com/neovim/neovim && \
    cd neovim && \
    git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    sudo make install && \
    cd /tmp && rm -rf /tmp/neovim*

# Adding my Neovim configuration
RUN cd /tmp && \
    git clone https://github.com/alfredojoseneto/Neovim.git && \
    cd Neovim && git checkout latest && \
    cp -r nvim $HOME/.config/ && \
    cd /tmp && rm -rf /tmp/Neovim*


# Defining the workding directory
WORKDIR /home/${DEFAULT_USER}/workdir

# How to build
# docker build --build-arg DEFAULT_USER=$(whoami) --build-arg GID=$(id -g) --build-arg UID=$(id -u) --tag dockerdev .

# How to run a named, hostnamed, mapped port and binded volume in interactive mode
# docker run --name <name> --hostmane <hostname> --publish 8080:80 --volume .:/home/$(whoami)/workdir/ -it dockerdev /bin/bash
