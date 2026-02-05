#!/bin/bash

VERSION=${1:-"v2.38.2"}
BIN_DIR="$HOME/.bin"

echo "Iniciando instalación de Docker Compose version: $VERSION"

mkdir -p "$BIN_DIR" || { echo "ERROR: No se pudo crear $BIN_DIR"; exit 1; }

grep -q "$BIN_DIR" ~/.bashrc || echo "export PATH=\"$BIN_DIR:\$PATH\"" >> ~/.bashrc || { echo "ERROR: No se pudo escribir en .bashrc"; exit 1; }

curl -fSL "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o "$BIN_DIR/docker-compose" || { 
    echo "ERROR: Falló la descarga. ¿Es '$VERSION' una versión válida?"
    exit 1 
}

chmod a+x "$BIN_DIR/docker-compose" || { echo "ERROR: No se pudieron dar permisos de ejecución"; exit 1; }

export PATH="$BIN_DIR:$PATH"
source ~/.bashrc || { echo "ERROR: No se puede hacer un source con .bashrc"; exit 1; }

INSTALLED_VERSION=$(docker-compose --version 2>/dev/null)
if [[ "$INSTALLED_VERSION" == *"$VERSION"* ]]; then
    echo "✅ Verificación exitosa: Docker Compose $VERSION instalado correctamente."
else
    echo "❌ ERROR: La versión detectada ($INSTALLED_VERSION) no coincide con la esperada ($VERSION)."
    exit 1
fi