# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer@sha256:d866e71c50e39b920a772b9e1cd825a2f1195abab0ad9abe97e5f759f1e81530
USER root
COPY sudoers /etc/sudoers.d/devcontainer
RUN apt-get install --yes --no-install-recommends --update --snapshot "$APT_SNAPSHOT_DATE" procps
USER vscode
