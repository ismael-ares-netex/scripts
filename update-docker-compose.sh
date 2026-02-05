#!/bin/bash

VERSION="v2.38.2"
BIN_DIR="$HOME/.bin"

echo "Iniciando instalación de Docker Compose versión: $VERSION"

mkdir -p "$BIN_DIR" || { echo "ERROR: No se pudo crear $BIN_DIR"; exit 1; }

if ! grep -q "$BIN_DIR" ~/.bashrc; then
    echo "Agregando $BIN_DIR al PATH en .bashrc..."
    echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.bashrc || { echo "ERROR: No se pudo escribir en .bashrc"; exit 1; }
fi

curl -fSL "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o "$BIN_DIR/docker-compose" || { 
    echo "ERROR: Falló la descarga. Verifica tu conexión o la versión '$VERSION'."
    exit 1 
}

chmod a+x "$BIN_DIR/docker-compose" || { echo "ERROR: No se pudieron dar permisos de ejecución"; exit 1; }

export PATH="$BIN_DIR:$PATH"

INSTALLED_VERSION=$(docker-compose --version 2>/dev/null)
if [[ "$INSTALLED_VERSION" == *"$VERSION"* ]]; then
    echo "✅ Verificación exitosa: Docker Compose $VERSION instalado correctamente."
else
    echo "❌ ERROR: La versión detectada ($INSTALLED_VERSION) no coincide con la esperada ($VERSION)."
    exit 1
fi