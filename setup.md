# DevTools Setup Guide

Quick reference for integrating DevTools into Symfony projects.

## 🚀 New Project

```bash
# 1. Add as submodule
git submodule add git@github.com:YOUR-USER/web-tools.git .devtools
git submodule update --init --recursive

# 2. Install
.devtools/install.sh

# 3. Configure .env (auto-generated from template)
# Review and adjust as needed

# 4. Start development
./develop.sh
```

## 🔄 Existing Project

```bash
# 1. Add as submodule
git submodule add git@github.com:YOUR-USER/web-tools.git .devtools
git submodule update --init --recursive

# 2. Migrate (backs up existing files)
.devtools/migrate.sh

# 3. Test
./docker-start.sh
./docker-list.sh
./docker-stop.sh

# 4. Commit
git add -A
git commit -m "Migrate to DevTools"
git push
```

## 📝 What Gets Created

### Wrapper Scripts

These forward to `.devtools/scripts/`:

```
clear-cache.sh          database-backup.sh      database-init.sh
database-migrate.sh     database.sh             develop.sh
develop-web-base.sh     docker-delete.sh        docker-list.sh
docker-start.sh         docker-stop.sh          docker-test.sh
lint.sh                 optimize-images.sh      php-cs-fixer.sh
php.sh                  phpunit.sh              pipeline.sh
yarn.sh
```

**Exception**: `deploy.sh` stays standalone (production compatibility)

### Symlinks

```
Dockerfile              → .devtools/docker/Dockerfile
docker-compose.*.yml    → .devtools/docker/compose/
docker/nginx            → .devtools/docker/nginx
```

### Files

```
.env                         # Created from .devtools/templates/.env.dist
docker-compose.override.yml  # Project-specific Docker settings
```

### Directories

```
mariadb/     # data, log, backup, fixtures
postgresql/  # data, log, backup, fixtures
```

## 🔧 Configuration

### .env

Auto-generated from `.devtools/templates/.env.dist` with:
- `APP_NAME` from composer.json
- `APP_SECRET` randomly generated
- Database credentials matching `APP_NAME`

### docker-compose.override.yml

For project-specific Docker customizations:

```yaml
services:
  php:
    environment:
      CUSTOM_VAR: value
```

## 🔄 Updates

```bash
# Update DevTools
git submodule update --remote .devtools
.devtools/install.sh  # If new scripts added
git add .devtools
git commit -m "Update DevTools"
```

## 🗑 Uninstall

```bash
# Remove integration (keeps backups)
.devtools/uninstall.sh

# Remove submodule
git submodule deinit -f .devtools
git rm -f .devtools
rm -rf .git/modules/.devtools
```

## 📚 Documentation

- **README.md** - Full documentation
- **SETUP.md** - This file (quick reference)
- See project root for integration docs

## ⚠️ Important

- **Never** edit files in `.devtools/` directly
- Use `docker-compose.override.yml` for customizations
- `.env` is not committed (in `.gitignore`)
- `deploy.sh` is standalone (not a wrapper)


## 🚀 Setup

### 1. DevTools als Submodule hinzufügen

```bash
# Im Projekt-Root
git submodule add git@github.com:DEIN-USER/web-tools.git .devtools
git submodule update --init --recursive
```

### 2. Installation ausführen

```bash
.devtools/install.sh
```

Das Script erstellt:
- ✅ Wrapper-Scripts für alle Helper-Tools
- ✅ Symlinks zu Docker Compose Files
- ✅ `.env` Datei (falls nicht vorhanden)
- ✅ `docker-compose.override.yml` Template
- ✅ Notwendige Verzeichnisse (mariadb, postgresql, etc.)

### 3. Konfiguration anpassen

Bearbeite `.env`:

```bash
APP_NAME=meinprojekt
APP_ENV=dev
DB=mariadb
DATABASE_URL="mysql://user:pass@mariadb:3306/dbname"
```

### 4. Entwicklung starten

```bash
./develop.sh
```

## 📋 Was wird erstellt?

### Wrapper-Scripts

Alle Scripts im Root sind Wrapper, die auf `.devtools/scripts/` verweisen:

```bash
clear-cache.sh
database-backup.sh
database-init.sh
database-migrate.sh
database.sh
develop.sh
develop-web-base.sh
docker-delete.sh
docker-list.sh
docker-start.sh
docker-stop.sh
docker-test.sh
lint.sh
optimize-images.sh
php-cs-fixer.sh
php.sh
phpunit.sh
pipeline.sh
yarn.sh
```

### Symlinks

- `Dockerfile` → `.devtools/docker/Dockerfile`
- `docker-compose.*.yml` → `.devtools/docker/compose/`
- `docker/nginx/` → `.devtools/docker/nginx/`

### Verzeichnisse

```
mariadb/
  ├── data/
  ├── log/
  ├── backup/
  └── fixtures/
postgresql/
  ├── data/
  ├── log/
  ├── backup/
  └── fixtures/
```

## 🔄 Updates

### DevTools aktualisieren

```bash
git submodule update --remote .devtools
git add .devtools
git commit -m "Update DevTools"
```

### Neue Scripts nach Update

```bash
.devtools/install.sh
```

## 🎯 Nächste Schritte

1. **Docker starten**: `./docker-start.sh`
2. **Datenbank initialisieren**: `./database-init.sh`
3. **Tests ausführen**: `./phpunit.sh`
4. **Development starten**: `./develop.sh`

## 📚 Dokumentation

- `.devtools/README.md` - Vollständige DevTools-Dokumentation
- `DEVTOOLS.md` - Projekt-spezifische Integration

## ⚠️ Wichtig

- **Niemals** Dateien in `.devtools/` direkt ändern
- Für projekt-spezifische Anpassungen: `docker-compose.override.yml`
- `.env` nicht committen (in `.gitignore`)
