#!/bin/bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DEVTOOLS_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$DEVTOOLS_DIR/.." && pwd)"

echo -e "${GREEN}DevTools Setup${NC}"

# Create .env
if [ ! -f "$PROJECT_ROOT/.env" ]; then
  echo -e "${YELLOW}Creating .env...${NC}"
  cp "$DEVTOOLS_DIR/templates/.env.dist" "$PROJECT_ROOT/.env"

  APP_NAME="myproject"
  [ -f "$PROJECT_ROOT/composer.json" ] && APP_NAME=$(grep -o '"name".*"[^"]*"' "$PROJECT_ROOT/composer.json" | head -1 | sed 's/.*"\([^/]*\)"/\1/' || echo "myproject")

  APP_SECRET=$(openssl rand -hex 32 2>/dev/null || cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 64 | head -n 1)

  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/APP_NAME=myproject/APP_NAME=$APP_NAME/" "$PROJECT_ROOT/.env"
    sed -i '' "s/APP_SECRET=CHANGE_ME_TO_RANDOM_SECRET/APP_SECRET=$APP_SECRET/" "$PROJECT_ROOT/.env"
    sed -i '' "s/DB_NAME=myproject/DB_NAME=$APP_NAME/" "$PROJECT_ROOT/.env"
    sed -i '' "s/DB_USER=myproject/DB_USER=$APP_NAME/" "$PROJECT_ROOT/.env"
  else
    sed -i "s/APP_NAME=myproject/APP_NAME=$APP_NAME/" "$PROJECT_ROOT/.env"
    sed -i "s/APP_SECRET=CHANGE_ME_TO_RANDOM_SECRET/APP_SECRET=$APP_SECRET/" "$PROJECT_ROOT/.env"
    sed -i "s/DB_NAME=myproject/DB_NAME=$APP_NAME/" "$PROJECT_ROOT/.env"
    sed -i "s/DB_USER=myproject/DB_USER=$APP_NAME/" "$PROJECT_ROOT/.env"
  fi
  echo -e "${GREEN}✓${NC} .env created"
fi

# Create directories
for dir in mariadb/{data,log,backup} postgresql/{data,log,backup}; do
  mkdir -p "$PROJECT_ROOT/$dir"
done

# Update .gitignore
if [ -f "$PROJECT_ROOT/.gitignore" ] && ! grep -q "###> DevTools ###" "$PROJECT_ROOT/.gitignore"; then
  cat >> "$PROJECT_ROOT/.gitignore" <<'GITIGNORE'

###> DevTools ###
docker-compose.override.yml
mariadb/data/*
mariadb/log/*
postgresql/data/*
postgresql/log/*
###< DevTools ###
GITIGNORE
fi

echo -e "${GREEN}✓ Setup complete${NC}"
echo ""
echo "All scripts are in .devtools/ directory:"
echo "  .devtools/develop.sh"
echo "  .devtools/docker-start.sh"
echo ""
EOF

chmod +x install.sh && echo "✓ Created install.sh"
