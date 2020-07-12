#!/usr/bin/env bash

dockerVMName='docker-parallels'
if command -v docker-machine &>/dev/null; then
  if [ "$(docker-machine status "${dockerVMName}")" = "Running" ]; then
    # Configure default docker-machine VM
    eval "$(docker-machine env "${dockerVMName}")"
  else
    # Ensure docker VM is started
    docker-machine start "${dockerVMName}"
    # Configure default docker-machine VM
    eval "$(docker-machine env "${dockerVMName}")"
    # Install QEMU handlers
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  fi
fi
