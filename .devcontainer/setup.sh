#!/usr/bin/env bash
set -euo pipefail

echo "=== Setting up CIL-Demos environment ==="

# Ensure conda is available
export PATH="/opt/conda/bin:${PATH}"

# Suppress all interactive prompts from conda (ToS acceptance, etc.)
export CONDA_ALWAYS_YES=true

echo "=== Creating conda environment (CPU-only) ==="
conda env create -f ".devcontainer/environment_cpu.yml" -n cil_demos

# Register the Jupyter kernel so notebooks can find it
echo "=== Registering Jupyter kernel ==="
/opt/conda/envs/cil_demos/bin/python -m ipykernel install \
    --user --name cil_demos --display-name "Python (CIL)"

echo "=== Setup complete ==="
echo "Activate the environment with: conda activate cil_demos"
echo "Or select the 'Python (CIL)' kernel in Jupyter/VS Code."
