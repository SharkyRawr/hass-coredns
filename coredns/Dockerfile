ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache coredns=1.9.3-r4 ca-certificates

# Copy data
COPY rootfs /
