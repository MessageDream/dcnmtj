#!/bin/sh

root_path=/

mkdir -p ${root_path}app/webapps
mkdir -p ${root_path}app/data
mkdir -p ${root_path}app/log/openjdk/ipserver
# mkdir -p ${root_path}app/log/mysql
# chmod 777 ${root_path}app/log/mysql
mkdir -p ${root_path}app/data/mssql/backup

cp tcmr.bak /app/data/mssql/backup/


docker exec -it tcmr_mssql /opt/mssql-tools/bin/sqlcmd \
-S localhost -U SA -P 'tcmr@123456' \
-Q 'CREATE DATABASE tcmr'


docker exec -it tcmr_mssql touch /var/opt/mssql/data/tcmr1.ndf

docker exec -it tcmr_mssql /opt/mssql-tools/bin/sqlcmd \
-S localhost -U SA -P 'tcmr@123456' \
-Q 'RESTORE DATABASE tcmr FROM DISK = "/var/opt/mssql/backup/tcmr.bak" WITH REPLACE, MOVE "tcmr_data1" TO "/var/opt/mssql/data/tcmr.mdf", MOVE "tcmr_data2" TO "/var/opt/mssql/data/tcmr1.ndf", MOVE "tcmr_log1" TO "/var/opt/mssql/data/tcmr_log.ldf"'

