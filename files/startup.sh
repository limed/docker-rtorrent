#!/bin/bash

set -xe

if [[ -z "${BASE_DIRECTORY}" ]]; then
    echo "Setting download directory to /data/rtorrent"
    BASE_DIRECTORY='/data/rtorrent'
fi

if [[ -z "${BIND_ADDRESS}" ]]; then
    echo "Setting local address to localhost"
    BIND_ADDRESS='localhost'
fi

sed \
    -i.bak \
    -e "s#%%BASE_DIRECTORY%%#"${BASE_DIRECTORY}"#g" \
    -e "s#%%BIND_ADDRESS%%#"${BIND_ADDRESS}"#g" \
    /config/rtorrent.rc

chown rtorrent:user "${BASE_DIRECTORY}"
chown -R rtorrent:user "${BASE_DIRECTORY}"/downloads

echo "Clearing lock.."
rm -f "${BASE_DIRECTORY}"/torrents/rtorrent.lock

echo "Starting rtorrent .. "
screen -dmUS rtorrent /usr/bin/rtorrent -n -o import=/config/rtorrent.rc
tail -f -n 1 /config/logs/rtorrent.log
