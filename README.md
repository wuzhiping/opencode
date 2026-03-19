```
docker run --pull always \
           --user root \
           --rm -it \
           -v $PWD/opencode/config:/root/.config/opencode \
           -v $PWD/opencode/share:/root/.local/share/opencode \
           -v $PWD/agents/tdd:/src \
           shawoo/opencode:latest \
           run --thinking --format json --log-level WARN --print-logs true \
           --continue \
           --dir /src \
           --agent build \
           "你有什么技能"
```
