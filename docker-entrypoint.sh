#!/bin/bash

#set --envo pipefail
#shopt -s nullglob

YAPI_PORT="${YAPI_PORT:=3001}"
YAPI_ACOUNT="${YAPI_ACOUNT:=admin@admin.com}"
YAPI_DB_SERVER="${YAPI_DB_SERVER:=10.101.1.17}"
YAPI_DB_NAME="${YAPI_DB_NAME:=yapi}"
YAPI_DB_PORT="${YAPI_DB_PORT:=56789}"
YAPI_DB_USER="${YAPI_DB_USER:=yapi}"
YAPI_DB_PASS="${YAPI_DB_PASS:=123456}"
YAPI_DB_AUTH="${YAPI_DB_AUTH:=yapi}"

config() {
    if [[ -z "${YAPI_PORT}" || -z "${YAPI_ACOUNT}" || -z "${YAPI_DB_SERVER}" || -z "${YAPI_DB_NAME}" || -z "${YAPI_DB_PORT}" || -z "${YAPI_DB_USER}" || -z "${YAPI_DB_PASS}" || -z "${YAPI_DB_AUTH}" ]]; then
        echo -e "\n\"YAPI_PORT\" or \"YAPI_ACOUNT\" or \"YAPI_DB_SERVER\" or \"YAPI_DB_NAME\" or \"YAPI_DB_PORT\" or \"YAPI_DB_USER\" or \"YAPI_DB_PASS\" or \"YAPI_DB_AUTH\" can not be empty!\n" && exit 1
    else
        sed -i "s#YAPI_PORT#${YAPI_PORT}#g"             /api/config.json
        sed -i "s#YAPI_ACOUNT#${YAPI_ACOUNT}#g"         /api/config.json
        sed -i "s#YAPI_DB_SERVER#${YAPI_DB_SERVER}#g"         /api/config.json
        sed -i "s#YAPI_DB_NAME#${YAPI_DB_NAME}#g"         /api/config.json
        sed -i "s#YAPI_DB_PORT#${YAPI_DB_PORT}#g"         /api/config.json
        sed -i "s#YAPI_DB_USER#${YAPI_DB_USER}#g"         /api/config.json
        sed -i "s#YAPI_DB_PASS#${YAPI_DB_PASS}#g"         /api/config.json
        sed -i "s#YAPI_DB_AUTH#${YAPI_DB_AUTH}#g"         /api/config.json

    fi
}

config

if [ "$1" = '--initdb' ]; then
   nohup node /api/vendors/server/install.js &
fi

if [ "$1" = '--help' ]; then
    echo "Usage:"
    echo "初始化db并启动: docker run -d -p 3001:3001 --name yapi yapi --initdb"
    echo "初始化后的账号为 config.json 配置的邮箱, 密码为 ymfe.org"
    echo "直接启动: docker kill yapi && docker rm yapi && docker run -d -p 3001:3001 --name yapi yapi"
    exit 1;
fi

node /api/vendors/server/app.js

#exec "$@"
