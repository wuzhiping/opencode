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


```
uv run ov admin list-accounts 
uv run ov admin register-user default shawoo --role user

{
  "url": "http://10.17.1.26:1933",
  "api_key": "e2e4a3adc4272ffd166fa1f8a326fcde71a35afcb9040db5f6d2a08f49550492 ",
  "agent_id": null,

  "account": "default",
  "user": "shawoo",

  "timeout": 60.0,
  "output": "table",
  "echo_command": true
}

```
