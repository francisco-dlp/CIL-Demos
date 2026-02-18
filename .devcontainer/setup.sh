#!/usr/bin/env bash
set -euo pipefail

echo "=== Setting up CIL-Demos environment ==="

# Check for GPU availability
if command -v nvidia-smi &>/dev/null; then
    echo "GPU detected:"
    nvidia-smi --query-gpu=name,memory.total --format=csv,noheader || true
    ENV_FILE=".devcontainer/environment.yml"
else
    echo "No GPU detected — installing CPU-only environment."
    echo "Some demos requiring GPU acceleration may not work."
    ENV_FILE=".devcontainer/environment_cpu.yml"
fi

# Create the conda environment
echo "=== Creating conda environment from ${ENV_FILE} ==="
conda env create -f "${ENV_FILE}" -n cil_demos || \
    conda env update -f "${ENV_FILE}" -n cil_demos

# Register the Jupyter kernel so notebooks can find it
echo "=== Registering Jupyter kernel ==="
CONDA_PREFIX="${HOME}/miniconda3"
"${CONDA_PREFIX}/envs/cil_demos/bin/python" -m ipykernel install \
    --user --name cil_demos --display-name "Python (CIL)"

echo "=== Setup complete ==="
echo "Activate the environment with: conda activate cil_demos"
echo "Or select the 'Python (CIL)' kernel in Jupyter/VS Code."
