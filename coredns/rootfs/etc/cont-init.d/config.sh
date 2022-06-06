#!/usr/bin/with-contenv bashio
# ==============================================================================
# CoreDNS config
# ==============================================================================

CONFIG="/etc/corefile.conf"
bashio::log.info "Configuring CoreDNS..."
tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/coredns.config \
    -out "${CONFIG}"