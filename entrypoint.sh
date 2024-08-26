#!/usr/bin/env sh

start_backend() {
    cd /app/packages/ui/certd-server
    nohup npm run start >> ./backend.log 2>&1 &
    cd -
}

start_frontend() {
    nginx
}

start_service() {
    start_backend
    start_frontend
}

start_service
