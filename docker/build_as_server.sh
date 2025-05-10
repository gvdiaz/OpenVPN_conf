#! /bin/bash

# Título: script para compilar y ejecutar contenedor alpine con openvpn en modo servidor
# Autor: Gustavo Vladimir Diaz

# Definiciones para scripts

# Debugging
echo $pwd # Visualización de carpeta actual en host

# Comandos
docker build -f Dockerfile_alpine --build-arg BUILD_MODE=server -t openvpn-builder .
docker run -it --rm -v $(pwd)/ovpn-data:/etc/openvpn openvpn-builder