#!/bin/bash

DB_VOLUME="odoo-docker-setup_db_main"

ODOO_VOLUME="odoo-docker-setup_odoo-main-data"

HOST_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/backup_data"

LOG_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/logs"

sudo find $HOST_PATH -type f -name '*.tar.gz' -mmin +1 -exec rm {} \;

sudo find $LOG_PATH -type f -name '*.log' -mmin +5 -exec rm {} \;

sudo docker run --rm -v "$DB_VOLUME:/data" -v "$HOST_PATH:/backup" busybox sh -c "tar czf /backup/odoo_db_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz /data"

sudo docker run --rm -v "$ODOO_VOLUME:/data" -v "$HOST_PATH:/backup" busybox sh -c "tar czf /backup/odoo_filestore_backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz /data"

# sudo docker run --rm -v "$DB_VOLUME:/data" -v "$HOST_PATH:/backup" busybox sh -c "tar xzf backup/odoo_db_backup_2025-02-21_08-49-37.tar.gz -C /"
# sudo docker run --rm -v "$ODOO_VOLUME:/data" -v "$HOST_PATH:/backup" busybox sh -c "tar xzf backup/odoo_filestore_backup_2025-02-21_08-49-40.tar.gz -C /"