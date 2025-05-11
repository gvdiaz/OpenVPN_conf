#!/bin/bash

# Execute based on BUILD_MODE
case "${BUILD_MODE}" in
    server)
        /opt/scripts/build_server.sh
        ;;
    client)
        /opt/scripts/build_client.sh
        ;;
    bash)
        /bin/bash
        ;;
    *)
        echo "Usage: BUILD_MODE must be either 'server' or 'client'"
        exit 1
        ;;
esac

# Keep container running if you want to inspect
tail -f /dev/null