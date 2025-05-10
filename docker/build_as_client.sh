#! /bin/bash

docker build --build-arg BUILD_MODE=client -t openvpn-builder .
docker run -it --rm -v $(pwd)/ovpn-data:/etc/openvpn openvpn-builder