# install
* curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-setup

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
* https://hermes-agent.nousresearch.com/docs/user-guide/cli
* hermes chat --skills llm-wiki --quiet -q "我有哪些知识库"

# api
* https://hermes-agent.nousresearch.com/docs/user-guide/features/api-server
```
vi ~/.hermes/.env
API_SERVER_ENABLED=true
API_SERVER_HOST=0.0.0.0
API_SERVER_PORT=8642
API_SERVER_KEY=change-me
API_SERVER_CORS_ORIGINS=http://localhost:8642,http://10.17.1.26:3888

hermes gateway
```

# profile
```
# Create a profile per user
hermes profile create alice
hermes profile create bob

# Configure each profile's API server on a different port
hermes -p alice config set API_SERVER_ENABLED true
hermes -p alice config set API_SERVER_PORT 8643
hermes -p alice config set API_SERVER_KEY alice-secret

hermes -p bob config set API_SERVER_ENABLED true
hermes -p bob config set API_SERVER_PORT 8644
hermes -p bob config set API_SERVER_KEY bob-secret

# Start each profile's gateway
hermes -p alice gateway &
hermes -p bob gateway &
```
1. 列出所有profile

hermes profile list 

2. 创建profile。` --clone` 参数会从当前配置文件复制 config、 .env 和 SOUL.md 文件。

hermes profile create demo --clone

3. 设置默认profile为demo

hermes profile use demo

4. 显示配置文件详细信息（主目录、配置等）

hermes profile show demo

hermes profile show default

5. `--profile` 选择本次调用要使用的 Hermes 配置文件(`default` profile中有 `infographic-creator`这个skill)

hermes --profile demo chat -Q -q '我有infographic-creator这个skills吗'

hermes --profile default chat -Q -q '我有infographic-creator这个skills吗'

# skills
* npx degit github:wuzhiping/skills/pptx-generator ~/.hermes/skills/pptx-generator --force
* ls ~/.hermes/skills/

# code
```
# pip install -q aiohttp

import json
import aiohttp
index = 0
url = "http://10.17.1.26:8642/v1/responses"
# async with aiohttp.ClientSession() as session:
async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=1800, connect=10)) as session:   
  async with session.post(
    url,
    headers = {
    "Authorization":"Bearer change-me",
    "Content-Type": "application/json"
    },
    json={
    "model": "hermes-agent",
    "input": "你有哪些skills",
    "instructions": "结尾加上【好的哦，亲】",
    "stream": True,
    "conversation":"demo4",
    },
    ssl=False) as resp:
    async for line in resp.content:
      line = line.decode('utf-8').strip()
      if line.startswith('data'):
          try:
            content = json.loads(line[5:])
            print(content)
          except Exception as e:
            pass
```
