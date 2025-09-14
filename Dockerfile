FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Éviter les interactions durant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installer uniquement les paquets nécessaires et nettoyer le cache APT
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 python3-pip python3-venv git wget \
        libgl1-mesa-dev libglib2.0-0 libsm6 libxrender1 libxext6 \
        libgoogle-perftools4 libtcmalloc-minimal4 libcusparse11 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Créer un environnement virtuel et installer les packages Python sans cache pip
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir \
        torch torchvision torchaudio timm simpleeval accelerate \
        --extra-index-url https://download.pytorch.org/whl/cu121

# Définir le PATH pour utiliser le venv par défaut
ENV PATH="/app/venv/bin:$PATH"
