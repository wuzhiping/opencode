# build
* docker build -t shawoo/hermes . -f Dockerfile --pull  --no-cache

# setup
* docker run --rm -it -v ~/.hermes:/opt/data shawoo/hermes setup

# gateway
* docker run -it --name=hermes -d -p 9119:9119 -p 8642:8642 -v ~/.hermes:/opt/data shawoo/hermes gateway

# dashboard
* docker exec -it hermes bash -c 'source "/opt/hermes/.venv/bin/activate" && hermes dashboard --host 0.0.0.0 --port 9119  --insecure'

# backup and restore
* hermes backup -o /home/gem/.openclaw/hermes-backup-$(date +%y%m%d-%H%M%S).zip
* hermes import hermes-backup-260416-132905.zip

# cli
* hermes chat --skills llm-wiki --quiet -q "我有哪些知识库"

# api
* https://hermes-agent.nousresearch.com/docs/user-guide/features/api-server
