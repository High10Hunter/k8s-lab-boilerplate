#!/usr/bin/env bash

# Exit on errors, undefined vars, and fail on piped commands
set -euo pipefail

# Prompt for USERNAME if not set
if [ -z "${USERNAME:-}" ]; then
  read -p "Enter USERNAME: " USERNAME
fi

# Prompt for APP_DIR if not set
if [ -z "${APP_DIR:-}" ]; then
  read -p "Enter APP_DIR: " APP_DIR
fi

# Prompt for VER if not set (default to 'latest')
if [ -z "${VER:-}" ]; then
  read -p "Enter version (default: latest): " input_ver
  VER=${input_ver:-latest}
fi

# Allow overriding the Dockerfile name, if desired
DOCKERFILE="${DOCKERFILE:-Dockerfile}"

echo
echo "=== Building Docker images for ${APP_DIR}:${VER} ==="
echo

# ARM64 build & push
IMAGE_ARM="${USERNAME}/${APP_DIR}:arm64"
echo "-> Building ${IMAGE_ARM} (linux/arm64)"
docker buildx build \
  --platform linux/arm64 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=arm64 \
  --push \
  -t "${IMAGE_ARM}" \
  -f "${APP_DIR}/${DOCKERFILE}" \
  "${APP_DIR}"
echo

# AMD64 build & push
IMAGE_AMD="${USERNAME}/${APP_DIR}:amd64"
echo "-> Building ${IMAGE_AMD} (linux/amd64)"
docker buildx build \
  --platform linux/amd64 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=amd64 \
  --push \
  -t "${IMAGE_AMD}" \
  -f "${APP_DIR}/${DOCKERFILE}" \
  "${APP_DIR}"
echo

MANIFEST="${USERNAME}/${APP_DIR}:${VER}"
echo "=== Creating or amending manifest ${MANIFEST} ==="

docker buildx imagetools create \
  -t "${MANIFEST}" \
  "${IMAGE_AMD}" \
  "${IMAGE_ARM}"

echo "DONE! Images pushed and manifest created."
