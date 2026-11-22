# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer@sha256:1c7333d9bc5c3b5dcef90d74e75d9001b324b737ac715ae7f577d9595c75bb41
USER root
COPY sudoers /etc/sudoers.d/devcontainer
RUN apt-get install --yes --no-install-recommends --update --snapshot "$APT_SNAPSHOT_DATE" procps
USER vscode
