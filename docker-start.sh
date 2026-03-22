#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Storm-Breaker Docker Start${NC}"
echo "==========================="

# Create .env if missing
if [ ! -f .env ]; then
    cp .env.example .env
fi

source .env

echo -e "${YELLOW}Building and starting containers...${NC}"
docker compose up -d --build

DOMAIN="${DOMAIN:-localhost}"

echo ""
echo -e "${GREEN}Storm-Breaker is running!${NC}"

if [ "$DOMAIN" = "localhost" ] || [ -z "$DOMAIN" ]; then
    echo -e "Access panel: ${GREEN}http://localhost:${HTTP_PORT:-80}${NC}"
else
    echo -e "Access panel: ${GREEN}https://${DOMAIN}${NC}"
    echo -e "Caddy will automatically provision a Let's Encrypt certificate."
fi

echo -e "Default credentials: admin / admin"
echo ""
echo -e "To stop: ${YELLOW}docker compose down${NC}"
echo -e "To view logs: ${YELLOW}docker compose logs -f${NC}"
