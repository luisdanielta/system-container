ARG julia_ver=1.10.4
ARG alpine_ver=3.20

# Base image with full Julia installation
FROM julia:${julia_ver} AS julia 

# Alpine Linux as lightweight runtime and file maintainer
FROM alpine:${alpine_ver}
USER root

COPY --from=julia /usr/local/julia /julia

# Default command to verify the installation
CMD ["ls", "-la", "/julia"]