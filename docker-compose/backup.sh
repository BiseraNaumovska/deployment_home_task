#!/bin/bash
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_TYPE="${1:-full}"

mkdir -p "$BACKUP_DIR"

if [ "$BACKUP_TYPE" == "schema_only" ]; then
    echo "Starting Schema-only Database Backup..."
    docker exec postgres_db pg_dump -U db_admin --schema-only active_network_db > "$BACKUP_DIR/db_schema_$TIMESTAMP.sql"
    echo "Backup completed: $BACKUP_DIR/db_schema_$TIMESTAMP.sql"
else
    echo "Starting Full Database Backup..."
    docker exec postgres_db pg_dump -U db_admin active_network_db > "$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
    echo "Backup completed: $BACKUP_DIR/db_backup_$TIMESTAMP.sql"
fi
