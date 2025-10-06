# Repository Guidelines

## Project Structure & Module Organization
- Root-level Mermaid diagrams (`input.mmd`, `output.png/svg`) document the self-hosted stack; update both the source `.mmd` and rendered outputs together.
- `github-ci-cd/` mirrors the same pattern for the CI/CD pipeline diagrams; keep filenames consistent (`input.mmd`, `output.png`).
- `.claude/CLAUDE.md` captures the architectural intent—review it before introducing new services or refactors so changes align with the mission.
- When adding runtime code, group each service (e.g., reverse proxy configs, SvelteKit sites, bots) in its own top-level directory with `src/` and `tests/` subfolders to keep components under the 300-line guideline.

## Build, Test, and Development Commands
- `npm install` — install shared Node.js tooling before generating diagrams or running scripts.
- `make lint` — ejecuta `hadolint` y `shellcheck` sobre la imagen base y los scripts de instalación.
- `make test` — construye la imagen base (`docker build`) y corre las suites Bats (`tests/infra`, `tests/scripts`); usa `LECREV_DRY_RUN=1` por defecto dentro de las pruebas del script.
- `npx @mermaid-js/mermaid-cli -i input.mmd -o output.png` — regenera el gráfico de arquitectura tras editar el Mermaid; repite el comando dentro de `github-ci-cd/`.
- `npm test` — placeholder; reemplázalo por el runner elegido (Vitest o Jest) cuando lleguen módulos de aplicación.

## Coding Style & Naming Conventions
- Favor plain JavaScript modules; avoid TypeScript per project principles.
- Keep files short (<300 lines) and extract helpers when they grow larger.
- Use kebab-case for directories (`sveltekit-site-1/`) and camelCase for JavaScript variables/functions; reserve SCREAMING_SNAKE_CASE for environment variables.
- Format code with Prettier (`npx prettier --write .`) once added; include a config alongside the first application module.

## Testing Guidelines
- Prefer Vitest para servicios Node/SvelteKit y agrega cobertura focalizada por cada directorio de servicio.
- Mantén la estructura `tests/` con subcarpetas por dominio (`infra/`, `scripts/`); los nuevos tests pueden seguir el patrón `<modulo>.spec.js` o `.bats` según corresponda.
- Ejecuta `make test` (o `make test-image`/`make test-install`) antes de abrir un PR y documenta requisitos adicionales (contenedores Docker, túneles) en la descripción.

## Commit & Pull Request Guidelines
- Follow the short, imperative commit style already in history (e.g., `layout architecture`); group diagram updates and code changes into separate commits when possible.
- Reference related issues in commit bodies or PR descriptions (`Refs #12`) and include before/after screenshots or command output for visual or CLI-facing updates.
- Ensure PRs summarize scope, testing evidence, and deployment impact, and mention any WSL2 or Docker configuration steps contributors must replicate.

## Environment & Security Notes
- Services run inside WSL2 Ubuntu with Cloudflare Tunnel, Caddy, PM2, and Docker; document port usage when introducing a new module.
- Keep secrets in `.env.local` files excluded from git; share required variable names in the PR and add sanitized examples to documentation if needed.
