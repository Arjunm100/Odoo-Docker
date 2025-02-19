#!/bin/bash

# docker exec 68e25c4e0d8a pg_dump -U main DB1 > /home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/backup_data/odoo_db_backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

DB_CONTAINER_ID="68e25c4e0d8a"

CONTAINER_ID="odoo-docker-setup_odoo_main_1"

HOST_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/backup_data"

FILE_NAME="odoo_data_backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"

# Database Backup
docker exec 68e25c4e0d8a pg_dump -U main DB1 > $HOST_PATH/odoo_db_backup_$(date +"%Y-%m-%d_%H-%M-%S").sql
# sudo docker exec -t 312c8ec94f46 pg_dumpall -c -U odoo18 > dump_`date +%Y-%m-%d"_"%H_%M_%S`.sql

docker exec odoo-docker-setup_odoo_main_1 tar -cvzf tmp/$FILE_NAME -C /var/lib odoo

docker cp $CONTAINER_ID:tmp/$FILE_NAME $HOST_PATH

# # Optional: Remove old backups, keeping last 3

# find $HOST_PATH -type f -name '*.tar.gz' -mtime +3 -exec rm {} \\\\;

# find $HOST_PATH -type f -name '*.sql' -mtime +3 -exec rm {} \\\\;

# echo "Backup completed successfully!"


docker exec -it  pg_dump -U odoo -d DB1 > $HOST_PATH/odoo_db_backup_$(date +"%Y-%m-%d_%H-%M-%S").sql