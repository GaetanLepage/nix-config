#!/bin/sh

if `nmcli connection show --active | grep wireguard > /dev/null`; then
    sudo systemctl stop wg-quick-wg0
    notify-send " wireguard off"
else
    sudo systemctl start wg-quick-wg0
    notify-send " wireguard on"
fi
