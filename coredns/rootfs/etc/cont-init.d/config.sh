#!/usr/bin/with-contenv bashio
# ==============================================================================
# CoreDNS config
# ==============================================================================

CONFIG="/etc/corefile.conf"
bashio::log.info "Configuring CoreDNS..."
if ! tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/coredns.config \
    -out "${CONFIG}"; then
    bashio::log.error "Failed to generate CoreDNS configuration"
    exit 1
fi

# Validate the generated config
if [[ ! -f "${CONFIG}" ]]; then
    bashio::log.error "Configuration file was not created"
    exit 1
fi
if ! coredns -conf "${CONFIG}" -validate; then
    bashio::log.error "CoreDNS configuration validation failed"
    exit 1
fi
bashio::log.info "CoreDNS configuration is valid"
