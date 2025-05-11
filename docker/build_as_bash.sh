docker build -f Dockerfile_alpine --build-arg BUILD_MODE=bash -t openvpn-builder .
docker run -it --rm -v $(pwd)/ovpn-data:/etc/openvpn openvpn-builder