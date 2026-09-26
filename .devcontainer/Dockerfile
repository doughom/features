FROM node:24-trixie-slim@sha256:8ec5d7557396cfe32d21c3f9c13072355ceab22b584578ca4bb28af31120cffe

COPY apt.conf /etc/apt/apt.conf.d/devcontainer
COPY zshrc /etc/skel/.zshrc
COPY sudoers /etc/sudoers.d/devcontainer

ARG SNAPSHOT_DATE="20260920T000000Z"

RUN apt-get install --yes --update --no-install-recommends ca-certificates=20250419 \
    && apt-get upgrade --yes --snapshot "$SNAPSHOT_DATE" \
    && apt-get install --yes --update --snapshot "$SNAPSHOT_DATE" --no-install-recommends \
        git=1:2.47.3-0+deb13u1 \
        procps=2:4.0.4-9 \
        python3=3.13.5-1 \
        sudo=1.9.16p2-3+deb13u2 \
        zsh=5.9-8+b24 \
    && useradd --create-home --shell /bin/zsh vscode

USER vscode
