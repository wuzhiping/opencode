docker pull ghcr.io/anomalyco/opencode:latest

version=$(docker run --rm ghcr.io/anomalyco/opencode:latest --version)
echo "$version"

docker build --no-cache -t shawoo/opencode:$version -t shawoo/opencode:latest .
docker push shawoo/opencode:$version
docker push shawoo/opencode:latest
