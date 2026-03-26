FROM ghcr.io/anomalyco/opencode:latest

# 安装依赖工具
RUN apk add --no-cache curl tree eza unzip

# 安装 uv（musl 版本）
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN uv python install
RUN uv python install 3.12
RUN uv python install 3.11
RUN uv python install 3.10

# 安装 bun（musl 版本，适配 Alpine）
RUN curl -L https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64-musl.zip -o bun.zip \
    && unzip bun.zip \
    && mv bun-linux-x64-musl/bun /usr/local/bin/bun \
    && chmod +x /usr/local/bin/bun \
    && rm -rf bun.zip bun-linux-x64-musl

ENV PATH="/usr/local/bin:$PATH"

ENV PATH="/root/.bun/bin:$PATH"

RUN opencode run hi

RUN bun x oh-my-opencode install --no-tui --claude=no --openai=no --gemini=no --copilot=no
# WORKDIR /root/.config/opencode
# RUN bun add oh-my-opencode --verbose

WORKDIR /tdd
COPY AGENTS.md /tdd/AGENTS.md
COPY pocket /tdd/pocket
