FROM python:3.10-slim
COPY --from=ghcr.io/astral-sh/uv:0.13.4 /uv /uvx /usr/local/bin/

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN uv sync --locked --extra dev --no-cache
ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

CMD ["mcp-simple-tool", "--transport", "sse", "--port", "8000"] 