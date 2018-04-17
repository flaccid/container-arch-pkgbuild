FROM archlinux/base as builder

MAINTAINER Chris Fordham <chris@fordham.id.au>

RUN pacman-key --init && \
    pacman-db-upgrade && \
    update-ca-trust && \
    pacman -Syu --noconfirm base-devel git archlinux-keyring && \
    useradd -d /usr/local/build -m -G wheel build

COPY sudoers.d/build /etc/sudoers.d/

FROM builder

VOLUME /usr/local/build/src

USER build

RUN mkdir -p "$HOME/src"

WORKDIR /usr/local/build/src

CMD makepkg -sfc --noconfirm --needed && \
    makepkg --printsrcinfo > .SRCINFO
