FROM bitnami/minideb

RUN install_packages ca-certificates

COPY blackbox_exporter  /bin/blackbox_exporter
COPY blackbox.yml       /config/blackbox.yml

EXPOSE      9115
ENTRYPOINT  [ "/bin/blackbox_exporter" ]
CMD         [ "--config.file=/config/blackbox.yml" ]
