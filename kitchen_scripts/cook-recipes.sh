#!/bin/bash

set -e

# This script lives one directory below the top level container-recipes directory
TOP_DIR=$(cd `dirname $0`/.. && pwd)

whoami

docker login code.ornl.gov:4567 -u atj -p $(cat /gitlab_registry_token)

# System directories in which to look for builds in
SYSTEMS=(titan summitdev)

# Loop through directory struction container-recipes/{SYSTEM}/{DISTRO}/{TAG} and build docker image
for SYSTEM in "${SYSTEMS[@]}" ; do
    SYSTEM_DIR=${TOP_DIR}/${SYSTEM}
    for DISTRO_DIR in $SYSTEM_DIR/*/ ; do
        DISTRO=$(basename ${DISTRO_DIR})
        for TAG_DIR in $DISTRO_DIR/*/ ; do
            cd ${TAG_DIR}
            TAG=$(basename ${TAG_DIR})
            FULL_TAG="code.ornl.gov:4567/olcf/container-recipes/${SYSTEM}/${DISTRO}:${TAG}"

            # Copy QEMU binary to build directory if we're building for a power system
            if [ "${SYSTEM}" == "summitdev" ]; then
                cp ../../qemu-ppc64le .
            fi

            docker build -t ${FULL_TAG} .
        done
    done
done