#!/usr/bin/env bash

echo "=== Setting up CIL-Demos environment ==="

# Ensure conda is available
export PATH="/opt/conda/bin:${PATH}"

# Suppress all interactive prompts from conda (ToS acceptance, etc.)
export CONDA_ALWAYS_YES=true

echo "conda location: $(which conda)"
echo "conda version: $(conda --version)"

echo "=== Creating conda environment (CPU-only) ==="
if conda env create -f ".devcontainer/environment_cpu.yml" -n cil_demos 2>&1; then
    echo "=== Environment created successfully ==="

    # Register the Jupyter kernel so notebooks can find it
    echo "=== Registering Jupyter kernel ==="
    /opt/conda/envs/cil_demos/bin/python -m ipykernel install \
        --user --name cil_demos --display-name "Python (CIL)"

    echo "=== Setup complete ==="
    echo "Select the 'Python (CIL)' kernel in Jupyter/VS Code."
else
    echo ""
    echo "!!! conda env create failed (see output above) !!!"
    echo "The Codespace will still start. You can try fixing the"
    echo "environment manually by running:"
    echo "  conda env create -f .devcontainer/environment_cpu.yml -n cil_demos"
    echo ""
fi
