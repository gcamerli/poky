FROM fedora:28

# Metadata
LABEL mantainer="Gius. Camerlingo <gcamerli@gmail.com>"
LABEL version="1.0"
LABEL description="Docker container for yocto."

# Update & system packages
RUN dnf -y update && \
    dnf -y install \
        gawk \
        make \
        wget \
        tar \
        bzip2 \
        gzip \
        python \
        python3 \
        unzip \
        perl \
        patch \
        diffutils \
        diffstat \
        git \
        subversion \
        cpp \
        gcc \
        gcc-c++ \
        glibc-devel \
        texinfo \
        chrpath \
        ccache \
        perl-Data-Dumper \
        perl-Text-ParseWords \
        perl-Thread-Queue \
        perl-bignum \
        rpcgen \
        socat \
        findutils \
        which \
        cpio \
        file \
        xz \
        screen \
        tmux \
        sudo \
        fluxbox \
        hostname \
        procps \
        tigervnc-server \
        vim \
        zsh \
        minicom

RUN dnf -y clean all

# Docker image name
ENV NAME=poky

# Timezone
ENV TZ="Europe/Paris"

# Vnc
RUN cp -af /etc/skel/ /etc/vncskel/ && \
    echo "export DISPLAY=1" >>/etc/vncskel/.bashrc && \
    mkdir  /etc/vncskel/.vnc && \
    echo "" | vncpasswd -f > /etc/vncskel/.vnc/passwd && \
    chmod 600 /etc/vncskel/.vnc/passwd

# Config
COPY build-install-dumb-init.sh /
RUN bash /build-install-dumb-init.sh
RUN rm /build-install-dumb-init.sh

# User
RUN echo "yocto ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -ms /bin/zsh yocto
USER yocto
ENV HOME=/home/yocto
WORKDIR $HOME

# Custom shell
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Poky v2.5 (sumo)
RUN git clone -b sumo git://git.yoctoproject.org/poky

# Entrypoint
CMD /bin/zsh
