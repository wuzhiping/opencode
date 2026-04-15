# build
* docker build -t shawoo/hermes . -f Dockerfile --pull  --no-cache

# setup
* docker run --rm -it -v ~/.hermes:/opt/data shawoo/hermes setup

# gateway
* docker run -it --name=hermes -d -p 9119:9119 -p 8642:8642 -v ~/.hermes:/opt/data shawoo/hermes gateway

# dashboard
* docker exec -it hermes bash -c 'source "/opt/hermes/.venv/bin/activate" && hermes dashboard --host 0.0.0.0 --port 9119  --insecure'
