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


# https://github.com/microsoft/markitdown
```
docker run --name markitdown -it -d -v $PWD/worker:/workspace -p 18001:8888 shawoo/markitdown
```
