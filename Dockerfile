FROM postgres:12.18-bullseye
#FROM postgres:11.22-bullseye

# ARG를 사용하여 변수를 정의합니다.
ARG DB_HOST
ARG DB_USER
ARG DB_NAME
ARG DB_PASSWORD
ARG DB_PORT

# 환경 변수로 설정합니다.
ENV DB_HOST=$DB_HOST
ENV DB_USER=$DB_USER
ENV DB_NAME=$DB_NAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_PORT=$DB_PORT

RUN sed -i 's:^#\s*ko_KR\.UTF-8 UTF-8\s*$:ko_KR.UTF-8 UTF-8:g' /etc/locale.gen
RUN sed -i 's:^#\s*en_US\.UTF-8 UTF-8\s*$:en_US.UTF-8 UTF-8:g' /etc/locale.gen
RUN locale-gen

ENV LANGUAGE=ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8
ENV LC_ALL=ko_KR.UTF-8

RUN apt-get update\
        && apt-get install gzip -y

RUN mkdir -p /docker-entrypoint-initdb.d
COPY initdb-address.sh /docker-entrypoint-initdb.d/updates_postgis.sh

COPY address20241Q_schema /var/lib/postgresql/backup/address20241Q_schema
COPY address20241Q_data /var/lib/postgresql/backup/address20241Q_data

#COPY update-postgis.sh /usr/local/bin
RUN chmod +x /docker-entrypoint-initdb.d/updates_postgis.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/updates_postgis.sh"]


