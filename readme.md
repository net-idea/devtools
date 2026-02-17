# Development Toos

**Centralized development environment and helper scripts for Symfony base web projects with Docker and Docker Compose environment.**

## Structure

```
.devtools/
├── docker/
│   ├── compose/       # Docker Compose files
│   ├── nginx/         # Nginx configuration
│   └── Dockerfile     # PHP container
├── templates/
│   └── .env.dist      # Environment template
├── *.sh               # Shell Helper scripts
├── install.sh         # Setup script
└── readme.md          # This file
```

## Quick Start

```bash
# 1. Add as submodule
git submodule add <REPO-URL> .devtools
git submodule update --init

# 2. Run setup
cd .devtools && ./install.sh

# 3. Start development
./develop.sh
```

## Usage

All scripts run from `.devtools/` directory:

### Development

```bash
./develop.sh              # Interactive development environment
./develop-web-base.sh     # With web-base package
```

### Docker

```bash
./docker-start.sh         # Start Docker stack
./docker-stop.sh          # Stop Docker stack
./docker-list.sh          # List services
./docker-test.sh          # Health checks
./docker-delete.sh        # Delete stack (with volumes)
```

### Database

```bash
./database-init.sh        # Initialize database
./database-migrate.sh     # Run migrations
./database-backup.sh      # Backup/restore
./database.sh             # Interactive management
```

### Code Quality

```bash
./phpunit.sh              # Run tests
./lint.sh                 # Lint code
./php-cs-fixer.sh         # Fix code style
./pipeline.sh             # Run full CI/CD pipeline
```

### Utilities

```bash
./php.sh <command>        # Run PHP in container
./yarn.sh <command>       # Run Yarn in container
./clear-cache.sh          # Clear Symfony cache
./optimize-images.sh      # Optimize images
```

## Configuration

### Environment (.env)

Auto-generated from `templates/.env.dist`:

```bash
APP_NAME=myproject        # From composer.json
APP_SECRET=<generated>    # Random 64-char hex
DB=mariadb                # or postgres
DATABASE_URL=...
```

### Project Customization

Create `docker-compose.override.yml` in project root:

```yaml
services:
  php:
    environment:
      CUSTOM_VAR: value
```

## Docker Services

- **PHP 8.3+**: FPM with Symfony optimizations
- **Nginx**: Web server
- **Node 20**: Webpack Encore
- **MariaDB 11.4** / **PostgreSQL**: Database
- **Adminer** (8091) / **phpMyAdmin** (8092): DB admin
- **Mailpit** (1025/8025): Mail testing

## Updates

```bash
# Update DevTools
git submodule update --remote .devtools

# Commit changes
git add .devtools
git commit -m "Update DevTools"
```

## Key Features

✅ No wrappers in project root - all scripts in `.devtools/`
✅ Automatic `.env` generation with secure secrets
✅ Single source of truth for Docker configuration
✅ Works from `.devtools/` directory
✅ Project-independent and reusable
✅ Full CI/CD pipeline support

## License

MIT
