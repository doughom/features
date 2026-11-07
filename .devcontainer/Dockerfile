# hadolint global ignore=DL3008,DL3066

FROM ghcr.io/doughom/devcontainer@sha256:73b47d6f3c1f532f637dcdb1a3964be587e166cd7f05d48b44f30b4d2ed78437
USER root
COPY sudoers /etc/sudoers.d/devcontainer
RUN apt-get install --yes --no-install-recommends --update --snapshot "$APT_SNAPSHOT_DATE" procps
USER vscode
