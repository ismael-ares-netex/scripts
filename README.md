# 🚀 Scripts de Automatización

Colección de scripts personales para facilitarme la vida.

## 🛠 Scripts disponibles

### 1. Actualizar Docker Compose
Instala o actualiza Docker Compose a la versión **v2.38.2** en el directorio `~/.bin/`.

**Comando:**
```bash
curl -s https://raw.githubusercontent.com/ismael-ares-netex/scripts/main/update-docker-compose.sh | bash
```
### 2. Actualizar Helium Browser
Instala o actualiza el navegador **Helium** descargando la última AppImage en `~/Documentos/` y creando un enlace simbólico en `~/.bin/`. ERROR: Crea carpeta ~ en el directorio donde se ejecuta. (Añadir en un futuro la conf automatica de .desktop)

**Comando:**
```bash
curl -s https://raw.githubusercontent.com/ismael-ares-netex/scripts/main/update-helium.sh | bash
```
### 3. Limpiar directorios
Limpia cualquier path con la seguridad de ver que borras (requiere exa, aunque si no tienes exa proximamente hare que por defecto tire ls) y con una cuenta atrás de seguridad.

**Comando:**
```bash
curl -s https://raw.githubusercontent.com/ismael-ares-netex/scripts/main/clean-path.sh | bash -s -- /path/to/clean
```
