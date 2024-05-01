#!/bin/bash

set -e
set -x

# 환경 변수 사용
start_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "시작 시간: $start_time"

echo "******PostgreSQL initialization******"
echo "ENV DB_HOST: $DB_HOST"
echo "ENV DB_USER: $DB_USER"
echo "ENV DB_NAME: $DB_NAME"
echo "ENV DB_PASSWORD: $DB_PASSWORD"
echo "ENV DB_PORT: $DB_PORT"


# PostgreSQL 데이터베이스 연결 정보 설정
#DB_USER="geoserver"
#DB_PASSWORD="geoserver"
#DB_HOST="10.10.96.45"
#DB_PORT="5432"
#DB_NAME="gis"
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_NAME=$DB_NAME
BACKUP_SCHEMA="/var/lib/postgresql/backup/address20241Q_schema"
BACKUP_FILE="/var/lib/postgresql/backup/address20241Q_data"


#--create 옵션 적용 시, -d 옵션 적용 불가. -d 옵션은 데이터베이스를 선택하는 옵션
#PGPASSWORD="$DB_PASSWORD" pg_restore -v --create --format=c  -U "$DB_USER" -j 8 -h "$DB_HOST" -p "$DB_PORT" --dbname=gis41310 "$BACKUP_FILE"

#스키마 복원
PGPASSWORD="$DB_PASSWORD" pg_restore -v --format=c  -U "$DB_USER" -j 8 -h "$DB_HOST" -p "$DB_PORT" --dbname="$DB_NAME" "$BACKUP_SCHEMA"
#스키마 복원 후 데이터 복원
PGPASSWORD="$DB_PASSWORD" pg_restore -v --format=c  -U "$DB_USER" -j 8 -h "$DB_HOST" -p "$DB_PORT" --dbname="$DB_NAME" "$BACKUP_FILE"

end_time=$(date +"%Y-%m-%d %H:%M:%S")
echo "종료 시간: $end_time"
