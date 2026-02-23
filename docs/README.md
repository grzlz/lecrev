# Documentacion Tecnica - lecrev

Esta carpeta contiene todos los diagramas de arquitectura del proyecto lecrev en formato Mermaid.

## Diagramas Disponibles

### 1. system-architecture.mmd
**Proposito**: Arquitectura general del sistema

Muestra la estructura completa de la infraestructura:
- Capa de Internet (usuarios, APIs externas)
- Capa Cloudflare (DNS + Tunnel cifrado)
- Capa de Proxy Inverso (Caddy)
- Capa de Aplicaciones (Bots, SvelteKit apps)
- Capa de Datos (PostgreSQL, Umami)
- Herramientas de gestion (PM2, Docker)

**Cuando consultarlo**: Para entender como todos los componentes se conectan.

### 2. deployment-flow.mmd
**Proposito**: Flujo completo de CI/CD

Documenta el proceso automatizado de despliegue:
1. Desarrollador hace push a GitHub
2. GitHub Actions se activa
3. Conexion SSH via Cloudflare Tunnel
4. Pull, build, y restart automatico con PM2
5. Notificacion de resultado

**Cuando consultarlo**: Para entender o modificar el pipeline de CI/CD.

### 3. main-interfaces.mmd
**Proposito**: Interfaces y configuraciones principales

Muestra las configuraciones clave:
- `ecosystem.config.js` (PM2)
- `Caddyfile` (Reverse Proxy)
- `config.yml` (Cloudflare Tunnel)
- `docker-compose.yml` (Servicios)
- Endpoints publicos expuestos

**Cuando consultarlo**: Para configurar nuevos servicios o modificar ruteo.

### 4. sequence-diagram.mmd
**Proposito**: Flujo de una peticion HTTP

Sigue el camino completo de una peticion web:
1. Usuario visita tudominio.com
2. DNS resuelve a Cloudflare
3. Tunnel cifrado a Caddy
4. Caddy enruta a aplicacion
5. Tracking de analytics (Umami)
6. Respuesta de vuelta al usuario

**Cuando consultarlo**: Para entender el flujo de datos o debuggear problemas de red.

## Como Visualizar los Diagramas

### Opcion 1: GitHub
Los archivos `.mmd` se renderizan automaticamente en GitHub. Solo abre el archivo en el navegador.

### Opcion 2: VS Code
Instala la extension **Markdown Preview Mermaid Support**:
1. Instala: `Markdown Preview Mermaid Support`
2. Abre cualquier archivo `.mmd`
3. Presiona `Cmd+Shift+V` (Mac) o `Ctrl+Shift+V` (Windows)

### Opcion 3: Mermaid Live Editor
1. Ve a https://mermaid.live/
2. Copia el contenido del archivo `.mmd`
3. Pegalo en el editor
4. Exporta como PNG, SVG, o PDF

### Opcion 4: CLI (mmdc)
```bash
# Instalar Mermaid CLI
npm install -g @mermaid-js/mermaid-cli

# Generar PNG
mmdc -i system-architecture.mmd -o system-architecture.png

# Generar SVG
mmdc -i deployment-flow.mmd -o deployment-flow.svg -b transparent
```

## Convenciones

### Colores
- **Azul** (#4299e1): Internet/Externo
- **Naranja** (#f6821f): Cloudflare
- **Verde** (#1f8b4c): Caddy/Proxy
- **Morado** (#5865f2): Discord Bot
- **Purpura** (#5850ec): Umami Analytics
- **Azul oscuro** (#336791): PostgreSQL
- **Gris oscuro** (#2d3748): Hardware/WSL2

### Flechas
- **Linea solida (-->)**: Flujo de datos principal
- **Linea punteada (-.->)**: Gestion/Control
- **Linea doble (<-->)**: Comunicacion bidireccional

### Etiquetas
Todas las etiquetas estan en espanol para mantener consistencia con la documentacion.

## Actualizar Diagramas

Cuando modifiques la arquitectura del proyecto:

1. **Actualiza el diagrama relevante** en esta carpeta
2. **Regenera las imagenes** (si usas PNG/SVG en el README)
3. **Verifica** que el diagrama renderice correctamente en GitHub
4. **Documenta** el cambio en el commit message

Ejemplo:
```bash
# Editar diagrama
vim docs/system-architecture.mmd

# Regenerar imagen (opcional)
mmdc -i docs/system-architecture.mmd -o output.svg -b transparent

# Commit
git add docs/system-architecture.mmd output.svg
git commit -m "docs: actualizar diagrama de arquitectura - agregar servicio X"
```

## Contribuir

Si encuentras errores en los diagramas o quieres agregar nuevos:

1. Abre un issue describiendo el cambio
2. O mejor aun, abre un PR con el diagrama actualizado
3. Asegurate de que el diagrama sea claro y use las convenciones de este proyecto

## Recursos

- **Sintaxis Mermaid**: https://mermaid.js.org/intro/
- **Ejemplos**: https://mermaid.js.org/ecosystem/integrations.html
- **Live Editor**: https://mermaid.live/

---

**Nota**: Estos diagramas son documentacion viva. Mantenlos actualizados conforme evoluciona el proyecto.
