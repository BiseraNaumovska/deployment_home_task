#!/bin/bash
BACKUP_DIR="./backups"

if [ -n "$1" ]; then
    RESTORE_FILE="$1"
else
    RESTORE_FILE=$(ls -t $BACKUP_DIR/*.sql 2>/dev/null | head -n 1)
fi

if [ -z "$RESTORE_FILE" ] || [ ! -f "$RESTORE_FILE" ]; then
    echo "ERROR: No SQL backup file found in $BACKUP_DIR!"
    exit 1
fi

echo "STARTING RESTORE from file: $RESTORE_FILE ..."

docker exec -i postgres_db psql -U db_admin -d postgres -c "DROP DATABASE IF EXISTS active_network_db;"
docker exec -i postgres_db psql -U db_admin -d postgres -c "CREATE DATABASE active_network_db;"

cat "$RESTORE_FILE" | docker exec -i postgres_db psql -U db_admin -d active_network_db

if [ $? -eq 0 ]; then
    echo "RESTORE SUCCESSFUL from $RESTORE_FILE!"
else
    echo "ERROR! RESTORE UNSUCCESSFUL !!!!!"
fi
