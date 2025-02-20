#!/bin/bash

DB_CONTAINER_ID="odoo-docker-setup_db_main_1"

CONTAINER_ID="odoo-docker-setup_odoo_main_1"

HOST_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/backup_data"

LOG_PATH="/home/cybrosys/Desktop/Docker/odoo-docker-setup/Backup_Cron/logs"

find $HOST_PATH -type f -name '*.tar.gz' -mmin +5 -exec rm {} \;

find $HOST_PATH -type f -name '*.sql' -mmin +5 -exec rm {} \;

sudo find $LOG_PATH -type f -name '*.log' -mmin +10 -exec rm {} \;

RESULT=$(sudo docker ps --format "{{.Names}}")

string='My long string'
if [[ $RESULT == *"$CONTAINER_ID"*  &&  $RESULT == *"$DB_CONTAINER_ID"* ]]; then
    FILE_NAME="odoo_data_backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"

    docker exec $DB_CONTAINER_ID pg_dump -U main DX > $HOST_PATH/odoo_db_backup_$(date +"%Y-%m-%d_%H-%M-%S").sql

    docker exec odoo-docker-setup_odoo_main_1 tar -cvzf tmp/$FILE_NAME -C /var/lib odoo

    docker cp $CONTAINER_ID:tmp/$FILE_NAME $HOST_PATH

    docker exec $CONTAINER_ID sh -c 'rm /tmp/*.tar.gz'
else
    echo "Containers are not online"
fi
