FROM ghcr.io/anomalyco/opencode:latest

# 安装依赖工具
RUN apk add --no-cache curl tree eza

# 安装 uv（musl 版本）
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN uv python install
RUN uv python install 3.12
RUN uv python install 3.11
RUN uv python install 3.10

WORKDIR /tdd
COPY AGENTS.md /tdd/AGENTS.md
COPY pocket /tdd/pocket
