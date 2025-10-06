#!/usr/bin/env bats

setup_file() {
  PROJECT_ROOT=$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)
  IMAGE_UNDER_TEST=${IMAGE_NAME:-lecrev/base}
  if command -v docker >/dev/null 2>&1; then
    docker_available=1
    if ! docker image inspect "$IMAGE_UNDER_TEST" >/dev/null 2>&1; then
      docker build -t "$IMAGE_UNDER_TEST" "$PROJECT_ROOT/infra/base-image" >/dev/null 2>&1
    fi
  else
    docker_available=0
  fi
}

@test "Node.js está disponible en la imagen base" {
  (( docker_available )) || skip "docker no está disponible"
  run docker run --rm "$IMAGE_UNDER_TEST" node -v
  [ "$status" -eq 0 ]
}

@test "PM2 está instalado globalmente" {
  (( docker_available )) || skip "docker no está disponible"
  run docker run --rm "$IMAGE_UNDER_TEST" pm2 -v
  [ "$status" -eq 0 ]
}

@test "pnpm está disponible" {
  (( docker_available )) || skip "docker no está disponible"
  run docker run --rm "$IMAGE_UNDER_TEST" pnpm -v
  [ "$status" -eq 0 ]
}

@test "El contenedor se ejecuta con el usuario app" {
  (( docker_available )) || skip "docker no está disponible"
  run docker run --rm "$IMAGE_UNDER_TEST" id -u
  [ "$status" -eq 0 ]
  [ "$output" = "1000" ]
}

@test "El directorio de trabajo es /srv/app" {
  (( docker_available )) || skip "docker no está disponible"
  run docker run --rm "$IMAGE_UNDER_TEST" pwd
  [ "$status" -eq 0 ]
  [ "$output" = "/srv/app" ]
}
