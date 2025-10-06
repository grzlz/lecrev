#!/usr/bin/env bats

setup_file() {
  PROJECT_ROOT=$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)
  INSTALL_SCRIPT="$PROJECT_ROOT/scripts/install-base-deps.sh"
}

@test "exige privilegios de superusuario por defecto" {
  run bash "$INSTALL_SCRIPT"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"superusuario"* ]]
}

@test "modo dry-run lista los comandos clave" {
  export LECREV_ALLOW_SUDOLESS=1
  export LECREV_DRY_RUN=1
  export SUDO_USER=tester
  run bash "$INSTALL_SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[dry-run] apt-get update"* ]]
  [[ "$output" == *"[dry-run] apt-get install --yes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"* ]]
  [[ "$output" == *"[dry-run] npm install --global pm2@latest"* ]]
  [[ "$output" == *"Instalación base completada."* ]]
}
