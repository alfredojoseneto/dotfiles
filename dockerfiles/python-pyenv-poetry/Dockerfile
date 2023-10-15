# Setting the default image
ARG BASE_IMAGE=debian:bookworm-slim

FROM ${BASE_IMAGE}

# Setting the default user
ARG DEFAULT_USER=default_user
ARG UID=1000
ARG GID=1000

# Setting some environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

USER root

RUN apt update && \
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
    zlib1g-dev 

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

# Installing pyenv
RUN curl https://pyenv.run | bash

# Adjusting pyenv environment variables
ENV PYENV_ROOT=/home/${DEFAULT_USER}/.pyenv
ENV PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH

# Installing python version
RUN pyenv install 3.12.0 && \
    pyenv global 3.12.0

# Installing poetry and configuring it
RUN curl -sSL https://install.python-poetry.org | python3 - && \
poetry config virtualenvs.in-project true && \
poetry config virtualenvs.prefer-active-python true

WORKDIR /home/${DEFAULT_USER}/workdir

# docker build --build-art DEFAULT_USER=$(whoami) --build-arg GID=$(id -g) --build-arg UID=$(id -u) --tag python:3.12.0v0.0.3 .

# Sobre o poetry é necessário configurar os virtualenvs. Para isso utilizar
# $ poetry config --list
# Procurar pelas configurações de interesse e ajustar