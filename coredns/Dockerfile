ARG BUILD_FROM
FROM $BUILD_FROM 

# Add env
ENV LANG C.UTF-8

# Setup base
#RUN apk add --no-cache coredns=1.9.3-r0 ca-certificates
RUN apk add --no-cache coredns-openrc ca-certificates musl unbound-libs git go && \
  git clone --depth=1 https://github.com/coredns/coredns -b v1.10.0 && \
  cd coredns && \
    go get github.com/openshift/coredns-mdns && echo "mdns:github.com/openshift/coredns-mdns" >> plugin.cfg && \
    go generate && go build && cp -v coredns /usr/bin/coredns && \
  cd .. && \
  rm -Rf coredns /root/.cache /root/go && apk del git go

# Copy data
COPY rootfs /
