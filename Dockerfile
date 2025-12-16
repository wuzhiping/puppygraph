FROM node:24-slim

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    python3 \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# 安装 uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:/root/.cargo/bin:${PATH}"


ENV UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple" \
    UV_PYTHON_INSTALL_MIRROR="https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download"

ENV UV_ENV_FILE=".env"

COPY ./puppygraph-mcp-server /app/puppygraph-mcp-server

WORKDIR /app/puppygraph-mcp-server

RUN npm install
RUN npm run build

WORKDIR /app/src
