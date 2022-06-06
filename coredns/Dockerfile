ARG BUILD_FROM
FROM $BUILD_FROM

# Add env
ENV LANG C.UTF-8

# Setup base
RUN apk add --no-cache coredns=1.8.6-r4 ca-certificates

# Copy data
COPY rootfs /
