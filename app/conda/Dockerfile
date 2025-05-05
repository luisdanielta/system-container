ARG conda_ver=25.1.1-2
ARG alpine_ver=3.20

# Base image with full Miniconda installation
FROM continuumio/miniconda3:${conda_ver} AS conda

# Alpine Linux as lightweight runtime and file maintainer
FROM alpine:${alpine_ver}

USER root

# Copies entire Miniconda installation from stage 1 to a temporary Alpine location
COPY --from=conda /opt/conda /conda

# Moves the copied files to the final location in Alpine and removes the temporary copy
RUN cp -a /conda/. /opt/conda
RUN rm -rf /conda

COPY .condarc /tmp/.condarc
COPY entrypoint.sh /tmp/entrypoint.sh

# Ensures the entrypoint script is executable
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT [ "/tmp/entrypoint.sh" ]

# Default command to verify the installation
CMD ["ls", "-la", "/opt/conda"]