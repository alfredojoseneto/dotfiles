# Imagem base
ARG BASE_IMAGE=debian:bullseye

FROM ${BASE_IMAGE}

ARG DEFAULT_USER=dokcerknime
ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

# Realizando os processos abaixo como usuário root
USER root

# Instalações de binários
RUN apt-get update && \
    # apt-get -y upgrade && \
    apt-get install -y \
    apt-utils \
    avahi-utils \
    bzip2 \
    coreutils \
    curl \
    dbus \
    git \
    gnupg \
    libgdk-pixbuf2.0-dev \
    libglib2.0-0 \
    libgtk-3-dev \
    libnss3-dev \
    libxcomposite1 \
    libxcursor1 \
    libxi6 \
    libxrandr2 \
    libxss-dev \
    libxss1 \
    libxtst6 \
    net-tools \
    python3-pip \
    python3-venv \
    sudo \
    unzip \
    vim \
    wget

# Adicionano repositório do Google Chrome
RUN /bin/bash -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
    >> /etc/apt/sources.list.d/google-chrome.list' && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Download do chromedriver
RUN wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
    rm -rf /tmp/chromedriver.zip

# Remove .deb files das instalações
RUN rm -rf /var/lib/apt/lists/*

# Instala o Knime
RUN wget https://download.knime.org/analytics-platform/linux/knime_4.7.1.linux.gtk.x86_64.tar.gz && \
    tar -xvf knime_4.7.1.linux.gtk.x86_64.tar.gz && \
    rm knime_4.7.1.linux.gtk.x86_64.tar.gz && \
    mv knime_4.7.1 /opt/knime

# Adicioando o knime ao PATH
ENV PATH /opt/knime:$PATH

# Adiciona os nodes de Python
RUN knime -nosplash -consolelog -application org.eclipse.equinox.p2.director \
    -r http://update.knime.com/community-contributions/trusted/4.7\
    -i de.mpicbg.tds.knime.scripting.python.feature.feature.group\
    -d /opt/knime

# Adiciona os nodes de Python
RUN knime -nosplash -consolelog -application org.eclipse.equinox.p2.director \
    -r http://update.knime.com/analytics-platform/4.7,http://update.knime.com/community-contributions/trusted/4.7,http://download.nodepit.com/palladian/4.7,http://update.knime.com/partner/4.7 \
    -i org.knime.python2.nodes \
    -d /opt/knime

# Adiciona os nodes do analytics plataform
RUN knime -nosplash -consoleLog -application org.eclipse.equinox.p2.director \
    -r https://update.knime.com/analytics-platform/4.7 \
    -i org.knime.features.python2.feature.group,org.knime.features.python3.scripting.feature.group \
    -d /opt/knime

# Instalação ODBC SQL Server 17
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    sudo apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get install -y unixodbc-dev && \
    apt-get install -y libgssapi-krb5-2

# Adicionando o ODBC ao PATH
ENV PATH /opt/mssql-tools/bin:$PATH

# Copia as configurações do knime para o diretório padrão
COPY preferences.epf /opt/knime

# Instala as dependências do Python
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Criação do usuário e grupo default
RUN groupadd -g ${GID} ${DEFAULT_USER} && \
    useradd --create-home --non-unique --gid ${GID} --uid ${UID} --shell /bin/bash ${DEFAULT_USER} && \
    usermod -aG sudo ${DEFAULT_USER}

# Ajustando configurações para o usuáio default e segunrança do root
RUN sed -i /etc/sudoers \
    -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -re 's/sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' \
    -re 's/^#includedir.*/## ***Removed the includedir directive*** ##/g' && \
    echo "${DEFAULT_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Criando diretórios a serem utilizados
RUN mkdir /home/${DEFAULT_USER}/Downloads && \
    mkdir /home/${DEFAULT_USER}/Knime

# Modificando para o usuário default
USER ${DEFAULT_USER}

# Define o diretório de trabalho
WORKDIR /home/${DEFAULT_USER}


# ENTRYPOINT ["knime", "-application", "org.knime.product.KNIME_BATCH_APPLICATION", "-nosplash", "-clean", "-reset", "--launcher.suppressErrors", "-workflowDir=/home/${DEFAULT_USER}/Knime", "-preferences=/opt/knime/preferences.epf"]

# ===================== MODOS DE COMO EXECUTAR O CONAINER =====================

# docker run --net=host -v /tmp/Downloads/:/home/dockernime/Downloads -v <local-knime-workflow>://home/dockernime/Knime <image-name>
