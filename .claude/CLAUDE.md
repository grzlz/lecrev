# lecrev - Self-hosting as Self-service

## Project Mission
Dignificar el open source en Hispanoamérica through practical self-hosting infrastructure.

**Philosophy**: "La nube ha resultado contraproducente" - Promote privacy-respecting, self-hosted alternatives to cloud services.

## Tech Stack
1. **Ubuntu** (WSL2 on Windows gaming laptop)
2. **JavaScript** (Node.js, SvelteKit)
3. **Docker** (for containerized services)

### Core Components
- **Reverse Proxy**: Caddy/Nginx (ports 80/443)
- **Process Manager**: PM2
- **Tunnel**: Cloudflare Tunnel (for secure external access)
- **Analytics**: Umami/Plausible (privacy-focused)
- **Database**: PostgreSQL (port 5432)

### Applications
- Discord Bot (Node.js/Python, port 3001)
- SvelteKit Site 1 (port 3002)
- SvelteKit Site 2 (port 3003)
- Analytics Dashboard (port 3004)

## Architecture Overview

**Flow**:
Internet → Cloudflare DNS → Cloudflare Tunnel → Caddy → Applications

**CI/CD**:
GitHub push → GitHub Actions → SSH via Cloudflare → git pull → npm build → pm2 restart

## Development Principles
- **Simple solutions** over enterprise-level complexity
- **No TypeScript** - pure JavaScript
- **Privacy-first** analytics (Umami/Plausible, not Google)
- **Self-hosted** everything possible
- Keep files under 300 lines (refactor when exceeded)

## Project Structure
```
/
├── input.mmd                  # Main architecture diagram (Mermaid)
├── output.png/svg             # Rendered architecture
├── github-ci-cd/
│   ├── input.mmd             # CI/CD sequence diagram
│   └── output.png            # Rendered CI/CD flow
├── package.json              # Project manifest
└── README.md                 # Project introduction (Spanish)
```

## Important Notes
- This is a **real production setup** on a gaming laptop, not a toy project
- All services run in WSL2 Ubuntu on Windows
- Target audience: Latin American developers wanting self-hosting methodology
- "Toda ayuda es bienvenida" - community contributions welcome
