ARG BUILD_FROM
FROM $BUILD_FROM 

# Add env
ENV LANG C.UTF-8

# Setup base
#RUN apk add --no-cache coredns=1.9.3-r0 ca-certificates
RUN apk add --no-cache coredns-openrc ca-certificates musl unbound-libs && \
    apk add --no-cache --virtual .build-deps git go && \
    git clone --depth=1 https://github.com/coredns/coredns -b v1.12.2 && \
    cd coredns && \
        go get github.com/openshift/coredns-mdns && \
        echo "mdns:github.com/openshift/coredns-mdns" >> plugin.cfg && \
        go generate && \
        go build && \
        cp -v coredns /usr/bin/coredns && \
    cd .. && \
    rm -Rf coredns /root/.cache /root/go && \
    apk del .build-deps

# Copy data
COPY rootfs /
