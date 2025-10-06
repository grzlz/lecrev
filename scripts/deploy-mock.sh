#!/usr/bin/env bash
# Simulated deploy sequence executed by CI with optional dry-run mode.
set -euo pipefail

DRY_RUN=${LECREV_DRY_RUN:-0}
SSH_TARGET=${LECREV_SSH_TARGET:-}
DEPLOY_BRANCH=${LECREV_DEPLOY_BRANCH:-main}
REMOTE_REPO_PATH=${LECREV_REMOTE_REPO_PATH:-/opt/lecrev}
REMOTE_APP_PATH=${LECREV_REMOTE_APP_PATH:-/opt/lecrev/app}
PM2_PROCESS=${LECREV_PM2_PROCESS:-lecrev-app}
INSTALL_COMMAND=${LECREV_INSTALL_COMMAND:-npm install}
BUILD_COMMAND=${LECREV_BUILD_COMMAND:-npm run build}
RESTART_COMMAND=${LECREV_RESTART_COMMAND:-pm2 reload ${PM2_PROCESS}}

log() {
  printf '[deploy] %s\n' "$*"
}

run_cmd() {
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    printf '[dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

remote_exec() {
  local command="$1"
  run_cmd ssh "${SSH_TARGET}" "${command}"
}

if [[ -z "${SSH_TARGET}" ]]; then
  if [[ "${DRY_RUN}" -eq 1 ]]; then
    SSH_TARGET="deploy@mock-host"
    log "LECREV_SSH_TARGET no definido; usando destino simulado ${SSH_TARGET}"
  else
    echo "LECREV_SSH_TARGET es obligatorio para ejecutar el despliegue" >&2
    exit 1
  fi
fi

if [[ "${DRY_RUN}" -eq 1 ]]; then
  log "Modo dry-run activado; no se ejecutarán comandos remotos reales"
fi

log "Actualizando repositorio remoto en ${SSH_TARGET}"
remote_exec "cd ${REMOTE_REPO_PATH} && git fetch --all --prune"
remote_exec "cd ${REMOTE_REPO_PATH} && git checkout ${DEPLOY_BRANCH}"
remote_exec "cd ${REMOTE_REPO_PATH} && git pull --ff-only origin ${DEPLOY_BRANCH}"

log "Instalando dependencias del front en ${REMOTE_APP_PATH}"
remote_exec "cd ${REMOTE_APP_PATH} && ${INSTALL_COMMAND}"

log "Construyendo artefactos"
remote_exec "cd ${REMOTE_APP_PATH} && ${BUILD_COMMAND}"

log "Reiniciando proceso con PM2 (${PM2_PROCESS})"
remote_exec "${RESTART_COMMAND}"

log "Despliegue simulado completado"
