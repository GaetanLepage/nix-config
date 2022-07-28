#!/bin/sh

type nmcli >/dev/null 2>&1 || exit


is_con_active() {
    return `nmcli connection show --active | grep $1 > /dev/null`
}

if `is_con_active wireguard`; then
    echo "%{F#0f0} wireguard%{F-}"

elif `is_con_active vpn_inria`; then
    echo "%{F#0f0} inria%{F-}"

else
    echo "%{F#f00} no vpn%{F-}"

fi
