FROM node:24-trixie-slim@sha256:8ec5d7557396cfe32d21c3f9c13072355ceab22b584578ca4bb28af31120cffe

COPY apt.conf /etc/apt/apt.conf.d/devcontainer
COPY zshrc /etc/skel/.zshrc
COPY sudoers /etc/sudoers.d/devcontainer

ARG SNAPSHOT_DATE="20260920T000000Z"

# hadolint ignore=DL3008
RUN apt-get install --yes --update --no-install-recommends ca-certificates \
    && apt-get upgrade --yes --snapshot "$SNAPSHOT_DATE" \
    && apt-get install --yes --update --snapshot "$SNAPSHOT_DATE" --no-install-recommends \
        git \
        procps \
        python3 \
        sudo \
        zsh \
    && useradd --create-home --shell /bin/zsh vscode

USER vscode
