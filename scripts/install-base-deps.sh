#!/usr/bin/env bash
set -euo pipefail

ALLOW_SUDOLESS=${LECREV_ALLOW_SUDOLESS:-0}
DRY_RUN=${LECREV_DRY_RUN:-0}

if [[ "${ALLOW_SUDOLESS}" -ne 1 && "${EUID}" -ne 0 ]]; then
  echo "Este script debe ejecutarse con privilegios de superusuario (sudo)." >&2
  exit 1
fi

run_cmd() {
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

DOCKER_USER="${SUDO_USER:-${USER}}"

run_cmd apt-get update
run_cmd apt-get install --yes --no-install-recommends \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common \
  unzip

# Node.js LTS (v20 a fecha de este guion)
if ! command -v node >/dev/null 2>&1; then
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -"
  else
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
  fi
  run_cmd apt-get install --yes nodejs
fi

# Docker Engine + CLI + Compose plugin
if ! command -v docker >/dev/null 2>&1; then
  run_cmd install -m 0755 -d /etc/apt/keyrings
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg"
  else
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  fi
  run_cmd chmod a+r /etc/apt/keyrings/docker.gpg
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \$(. /etc/os-release && echo \$VERSION_CODENAME) stable\" > /etc/apt/sources.list.d/docker.list"
  else
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list
  fi
  run_cmd apt-get update
  run_cmd apt-get install --yes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  run_cmd usermod -aG docker "$DOCKER_USER"
fi

# PM2 para gestión de procesos Node
if ! command -v pm2 >/dev/null 2>&1; then
  run_cmd npm install --global pm2@latest
fi

# Caddy (reverse proxy)
if ! command -v caddy >/dev/null 2>&1; then
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/gpg.key | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg"
    printf '[dry-run] %s\n' "curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/deb/debian/caddy-stable.list | tee /etc/apt/sources.list.d/caddy-stable.list"
  else
    curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/gpg.key | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -fsSL https://dl.cloudsmith.io/public/caddy/stable/deb/debian/caddy-stable.list | tee /etc/apt/sources.list.d/caddy-stable.list
  fi
  run_cmd apt-get update
  run_cmd apt-get install --yes caddy
fi

# Cloudflared para el túnel seguro
if ! command -v cloudflared >/dev/null 2>&1; then
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "curl -fsSL https://pkg.cloudflare.com/cloudflared.asc | gpg --dearmor -o /usr/share/keyrings/cloudflared.gpg"
    printf '[dry-run] %s\n' "echo \"deb [signed-by=/usr/share/keyrings/cloudflared.gpg] https://pkg.cloudflare.com/ \$(lsb_release -c -s) main\" > /etc/apt/sources.list.d/cloudflared.list"
  else
    curl -fsSL https://pkg.cloudflare.com/cloudflared.asc | gpg --dearmor -o /usr/share/keyrings/cloudflared.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloudflared.gpg] https://pkg.cloudflare.com/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/cloudflared.list
  fi
  run_cmd apt-get update
  run_cmd apt-get install --yes cloudflared
fi

cat <<MSG
Instalación base completada.
- Reinicia la shell o ejecuta 'newgrp docker' para aplicar permisos del grupo docker.
- Configura llaves y túneles de Cloudflare manualmente antes de exponer servicios.
MSG
