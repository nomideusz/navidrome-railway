#!/bin/sh
set -e
mkdir -p /data/music /data/navidrome

# Filebrowser: admin credentials come from env on first boot only.
if [ ! -f /data/filebrowser.db ]; then
  filebrowser config init -d /data/filebrowser.db \
    --branding.name "Music uploads" >/dev/null
  filebrowser users add "${FILEBROWSER_USER:-admin}" \
    "${FILEBROWSER_PASSWORD:?FILEBROWSER_PASSWORD not set}" \
    --perm.admin -d /data/filebrowser.db >/dev/null
fi
filebrowser -d /data/filebrowser.db -r /data/music \
  -a 0.0.0.0 -p "${FILEBROWSER_PORT:-8080}" &

exec /app/navidrome
