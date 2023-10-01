# ARG BASE_IMAGE=debian:bookworm-slim
ARG BASE_IMAGE=debian:bookworm

FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

ARG DEFAULT_USER=default_user
ARG UID=1000
ARG GID=1000

USER root

# Install the main packaker
RUN apt update && \
    apt install -y \
    curl \
    git \
    # nodejs \
    npm \
    pip \
    # python3 \
    # python3-venv \
    sudo \
    wget

# Installing lvim iside step 01
# RUN cd /tmp && \
#     git clone https://github.com/neovim/neovim && \
#     cd neovim && \
#     git checkout stable && \
#     make install

# Installing lvim iside step 02
# RUN curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh > install.sh && \
#     chmod +x install.sh && \
#     bash ./install.sh && \
#     echo "alias lvim=/root/.local/bin/lvim" >> /root/.bashrc

# Adjusinting paramteres for a default user like user host
# O "_" in the first sed is modifiing the delimiter
RUN sed -i /etc/sudoers \
    -re 's/root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -re 's/%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -re 's_@includir.*_#### Removed includir ####_'

RUN echo "${DEFAULT_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN groupadd --non-unique --gid 1000 ${DEFAULT_USER} && \
    useradd --non-unique --create-home --uid ${UID} --gid ${GID} ${DEFAULT_USER}

USER ${DEFAULT_USER}

# Adicionado o bashrc
RUN touch ~/.bashrc && chmod +x ~/.bashrc

# Definindo a versão default do nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh > /tmp/nvm.sh && \
    chmod +x /tmp/nvm.sh && \
    bash /tmp/nvm.sh && \
    /tmp/nvm.sh install lts/hydrogen && \
    /tmp/nvm.sh alias default lts/hydrogen

WORKDIR /home/${DEFAULT_USER}

