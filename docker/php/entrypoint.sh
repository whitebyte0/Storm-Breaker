#!/bin/sh
# Ensure writable directories exist and have correct ownership for www-data
DIRS="images sounds log"
for dir in $DIRS; do
    mkdir -p "/var/www/html/$dir"
    chown -R www-data:www-data "/var/www/html/$dir"
done

# Ensure writable files have correct ownership
FILES="check-c.json"
for file in $FILES; do
    if [ -f "/var/www/html/$file" ]; then
        chown www-data:www-data "/var/www/html/$file"
    fi
done

# Also fix template result.txt files
find /var/www/html/templates -name "result.txt" -exec chown www-data:www-data {} \; 2>/dev/null || true

exec "$@"
