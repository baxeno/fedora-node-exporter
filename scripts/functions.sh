#!/bin/bash

source cfg.sh

IMAGE="prom/node-exporter"
if [ -z "${REVISION}" ]; then
  REVISION="v0.15.2"
fi
if [ -z "${CONTAINER_NAME}" ]; then
  CONTAINER_NAME="node-exporter"
fi

print_header()
{
  echo "--------------------------------------------------"
  echo "Prometheus node-exporter ${1}"
  echo " - Image: ${IMAGE}"
  echo " - Version: ${REVISION}"
  echo " - Container name: ${CONTAINER_NAME}"
  echo "--------------------------------------------------"
  echo
}

setup()
{
  docker run -d \
    --restart unless-stopped \
    --name "${CONTAINER_NAME}" \
    -p 9100:9100 \
    -v "/proc:/host/proc:ro" \
    -v "/sys:/host/sys:ro" \
    -v "/:/rootfs:ro,rslave" \
    --cap-add=SYS_TIME \
    "${IMAGE}:${REVISION}" \
    --path.procfs="/host/proc" \
    --path.sysfs="/host/sys" \
    --collector.filesystem.ignored-mount-points="^/(sys|proc|dev|host|etc)($|/)" \
    --web.listen-address="0.0.0.0:9100"
}

teardown()
{
  docker stop "${CONTAINER_NAME}"
  docker rm "${CONTAINER_NAME}"
}
