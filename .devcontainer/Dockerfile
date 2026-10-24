# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer@sha256:75a62ccda6fea2a0a75a19ba63dcc7dd087d6a58b86cf1e33debce05998f5079
USER root
COPY sudoers /etc/sudoers.d/devcontainer
RUN apt-get install --yes --no-install-recommends --update --snapshot "$APT_SNAPSHOT_DATE" procps
USER vscode
