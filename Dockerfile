FROM ghcr.io/anomalyco/opencode:latest

# 安装依赖工具
RUN apk add --no-cache curl

# 安装 uv（musl 版本）
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"
