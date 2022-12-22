# Build the pi4-temperature2graphite container image with a Dockerfile
REL=${1:-v1.0}
cat ~/.ghcr-token | docker login ghcr.io -u gdha --password-stdin
echo "Building pi4-temperature2graphite:$REL"
docker build --tag ghcr.io/gdha/pi4-temperature2graphite:$REL  .
docker tag ghcr.io/gdha/pi4-temperature2graphite:$REL ghcr.io/gdha/pi4-temperature2graphite:latest
echo "Pushing pi4-temperature2graphite:$REL to GitHub Docker Container registry"
docker push ghcr.io/gdha/pi4-temperature2graphite:$REL
