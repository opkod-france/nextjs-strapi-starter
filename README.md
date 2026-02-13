# Next.js + Strapi v5 + PostgreSQL Starter

A production-ready monorepo template for full-stack projects with **Next.js 15** (App Router), **Strapi v5** CMS, and **PostgreSQL**.

## Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Next.js 15, TypeScript, Tailwind CSS |
| CMS / API | Strapi v5, TypeScript |
| Database | PostgreSQL 16 |
| Monorepo | Yarn Workspaces + Turborepo |
| Dev infra | Docker Compose, Traefik (local SSL) |
| Deploy | Dokploy-ready |

## Quick Start

```bash
npx create-nss my-project
```

The interactive wizard will ask you to choose:
- **Upload provider**: ImageKit, AWS S3, or Local
- **Email provider**: Brevo (Opkod), Nodemailer, SendGrid, or Mailgun
- **Strapi plugins**: GraphQL, i18n, SEO
- **Domains**: local `.dev` domains with SSL via Traefik

Then:
```bash
cd my-project
docker compose up -d     # start PostgreSQL + Traefik
yarn dev                 # start dev servers
```

## Project Structure

```
├── apps/
│   ├── web/          # Next.js frontend
│   └── api/          # Strapi v5 backend
├── docker/
│   ├── Dockerfile.api
│   ├── Dockerfile.web
│   └── certs/        # Local SSL certificates
├── scripts/
│   ├── setup.sh
│   └── generate-certs.sh
├── docker-compose.yml       # Dev: PostgreSQL + Traefik
├── docker-compose.prod.yml  # Prod: full stack with Let's Encrypt
├── turbo.json
└── package.json
```

## Scripts

| Command | Description |
|---------|-------------|
| `yarn dev` | Start both Next.js and Strapi in dev mode |
| `yarn build` | Build both apps for production |
| `yarn lint` | Lint both apps |
| `yarn type-check` | TypeScript check both apps |
| `yarn setup` | Re-run setup (secrets, deps, certs) |
| `yarn generate-certs` | Regenerate local SSL certificates |

## Production Deployment (Docker)

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

This starts PostgreSQL, Strapi, Next.js, and Traefik with automatic Let's Encrypt SSL.

## License

MIT
