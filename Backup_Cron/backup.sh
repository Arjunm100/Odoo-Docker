#!/bin/bash

DB_VOLUME="odoo-docker-setup_db_main"

ODOO_VOLUME="odoo-docker-setup_odoo-main-data"

HOST_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/backup_data"

LOG_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/logs"

find $HOST_PATH -type f -name '*.tar' -mmin +1 -exec rm {} \;

sudo find $LOG_PATH -type f -name '*.log' -mmin +5 -exec rm {} \;

docker run --rm -v "$DB_VOLUME:/data" -v "$HOST_PATH:/backup" busybox sh -c 'tar czf /backup/db_backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz /data'

docker run --rm -v "$ODOO_VOLUME:/data" -v "$HOST_PATH:/backup" busybox -c 'tar cvf /backup/odoo_backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz /data'
