FROM ghcr.io/astral-sh/uv:debian

WORKDIR /app

ENV UV_ENV_FILE=".env"

RUN uv init && uv add "openviking[bot-full]"

COPY ov.conf .
COPY ovcli.conf .

COPY .env .


EXPOSE 1933 18790

CMD ["uv", "run", "--env-file", ".env", "openviking-server", "--with-bot", "--bot-url", "0.0.0.0:18790"]
