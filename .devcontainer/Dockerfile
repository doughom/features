# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer@sha256:c6177c15566a3621143d18ac8e68443e7b86e3a89ce5aac6bae767370f2c28ba
USER root
COPY sudoers /etc/sudoers.d/devcontainer
RUN apt-get install --yes --no-install-recommends --update --snapshot "$APT_SNAPSHOT_DATE" procps
USER vscode
