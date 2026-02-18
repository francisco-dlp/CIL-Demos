FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user for Codespaces
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m vscode -s /bin/bash \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode

# Install Miniconda system-wide so it's available to all shells
ENV CONDA_DIR=/opt/conda
RUN wget -qO /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/miniconda.sh -b -p "${CONDA_DIR}" \
    && rm /tmp/miniconda.sh \
    && "${CONDA_DIR}/bin/conda" init bash \
    && chown -R vscode:vscode "${CONDA_DIR}"

# Ensure conda is on PATH for all users and all shell types (sh, bash, etc.)
ENV PATH="${CONDA_DIR}/bin:${PATH}"

USER vscode
