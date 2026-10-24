# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer:26.10.24@sha256:d30478ee09a6d11221cbaff670f61507f405cdd607a87b7d4bfcc3fa8fbb2de7
USER root
COPY sudoers /etc/sudoers.d/devcontainer
ARG SNAPSHOT_DATE="20261023T000000Z"

RUN apt-get install --yes --update --snapshot "$SNAPSHOT_DATE" --no-install-recommends procps

USER vscode
