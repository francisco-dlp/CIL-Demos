FROM nvidia/cuda:12.6.3-cudnn-runtime-ubuntu22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user (vscode) for Codespaces
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid 1000 -m vscode -s /bin/bash \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode

# Install Miniconda as the vscode user
USER vscode
ENV HOME=/home/vscode
ENV CONDA_DIR=/home/vscode/miniconda3
RUN wget -qO /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/miniconda.sh -b -p "${CONDA_DIR}" \
    && rm /tmp/miniconda.sh

# Put conda on PATH
ENV PATH="${CONDA_DIR}/bin:${PATH}"

# Initialize conda for bash
RUN conda init bash

USER vscode
