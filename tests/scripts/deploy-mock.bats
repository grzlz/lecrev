#!/usr/bin/env bats

setup_file() {
  PROJECT_ROOT=$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)
  DEPLOY_SCRIPT="$PROJECT_ROOT/scripts/deploy-mock.sh"
}

@test "requiere LECREV_SSH_TARGET cuando no es dry-run" {
  unset LECREV_DRY_RUN
  unset LECREV_SSH_TARGET
  run bash "$DEPLOY_SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"LECREV_SSH_TARGET"* ]]
}

@test "modo dry-run asigna destino simulado si falta LECREV_SSH_TARGET" {
  export LECREV_DRY_RUN=1
  unset LECREV_SSH_TARGET
  run bash "$DEPLOY_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"destino simulado"* ]]
  [[ "$output" == *"[dry-run] ssh deploy@mock-host"* ]]
}

@test "modo dry-run lista comandos principales" {
  export LECREV_DRY_RUN=1
  export LECREV_SSH_TARGET="ops@example.com"
  export LECREV_REMOTE_REPO_PATH="/srv/lecrev"
  export LECREV_REMOTE_APP_PATH="/srv/lecrev/app"
  export LECREV_PM2_PROCESS="lecrev-app"
  run bash "$DEPLOY_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[dry-run] ssh ops@example.com cd /srv/lecrev && git fetch --all --prune"* ]]
  [[ "$output" == *"[dry-run] ssh ops@example.com cd /srv/lecrev/app && npm install"* ]]
  [[ "$output" == *"[dry-run] ssh ops@example.com pm2 reload lecrev-app"* ]]
  [[ "$output" == *"Despliegue simulado completado"* ]]
}
