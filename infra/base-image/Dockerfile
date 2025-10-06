# syntax=docker/dockerfile:1.7

FROM node:20-bookworm-slim AS base

LABEL org.opencontainers.image.title="lecrev base runtime"
LABEL org.opencontainers.image.description="Node.js + PM2 base image for self-hosted services in the lecrev stack"
LABEL org.opencontainers.image.source="https://github.com/grzlz/lecrev"
LABEL org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive \
    APP_HOME=/srv/app

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        curl \
        git \
        dumb-init \
        openssl \
        python3 \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --location=global pm2@latest pnpm@9.x

RUN groupadd --gid 1000 app \
    && useradd --uid 1000 --gid app --shell /bin/bash --create-home app \
    && mkdir -p "$APP_HOME" \
    && chown -R app:app "$APP_HOME"

WORKDIR $APP_HOME

USER app

ENV PATH="$APP_HOME/node_modules/.bin:$PATH"

COPY --chown=app:app package.json package-lock.json* pnpm-lock.yaml* ./

RUN if [ -f package.json ]; then \
        if [ -f pnpm-lock.yaml ]; then pnpm install --frozen-lockfile || pnpm install; \
        elif [ -f package-lock.json ]; then npm ci || npm install; \
        else npm install; fi; \
    fi

ENTRYPOINT ["dumb-init", "--"]
CMD ["pm2-runtime", "ecosystem.config.cjs"]
