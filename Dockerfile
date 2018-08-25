FROM archlinux/base as builder

MAINTAINER Chris Fordham <chris@fordham.id.au>

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syyu --noconfirm base-devel git archlinux-keyring curl tar && \
    useradd -d /usr/local/build -m -G wheel build

COPY sudoers.d/build /etc/sudoers.d/

USER build

RUN cd /tmp && \
    curl https://aur.archlinux.org/cgit/aur.git/snapshot/aurman.tar.gz > aurman.tar.gz && \
    tar zxvf aurman.tar.gz && \
    cd aurman && \
    makepkg -s --noconfirm --needed && \
    sudo pacman -U --noconfirm ./aurman*.tar.xz

FROM builder

VOLUME /usr/local/build/src

USER build

RUN mkdir -p "$HOME/src"

WORKDIR /usr/local/build/src

COPY docker-entrypoint.sh /opt/bin/docker-entrypoint.sh

ENTRYPOINT ["/opt/bin/docker-entrypoint.sh"]

CMD sudo pacman -Sy && \
    makepkg -sfc --noconfirm --needed && \
    makepkg --printsrcinfo > .SRCINFO
