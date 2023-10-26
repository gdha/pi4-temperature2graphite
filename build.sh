# Build the pi4-temperature2graphite container image with a Dockerfile
# To build with a new version: ./build.sh v1.1
REL=${1:-v1.0}
if [[ "$1" == "" ]]; then
  # no argument given - we will try to see if we already have old images locally
  CURRENT_SUB_VERSION=$(docker image ls 2>/dev/null| grep pi4-temperature | grep -v latest | head -1 | awk '{print $2}' | cut -d. -f2)
  if [[ "$CURRENT_SUB_VERSION" == "" ]]; then
    REL=${1:-v1.0}
  else
    NEW_SUB_VERSION=$((CURRENT_SUB_VERSION + 1))
    REL="v1.${NEW_SUB_VERSION}"
  fi
else
  # We have an argument on the command line, e.g. v1.6
  REL=${1:-v1.0}
fi
cat ~/.ghcr-token | docker login ghcr.io -u gdha --password-stdin
echo "Copy /usr/local/bin/k3s to $PWD"
cp /usr/local/bin/k3s .
echo "Building pi4-temperature2graphite:$REL"
docker build --tag ghcr.io/gdha/pi4-temperature2graphite:$REL  .
[[ $? -ne 0 ]] && exit 1
docker tag ghcr.io/gdha/pi4-temperature2graphite:$REL ghcr.io/gdha/pi4-temperature2graphite:latest
echo "Pushing pi4-temperature2graphite:$REL to GitHub Docker Container registry"
docker push ghcr.io/gdha/pi4-temperature2graphite:$REL
