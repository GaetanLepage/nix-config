#!/bin/sh

type nmcli >/dev/null 2>&1 || exit

source $XDG_CONFIG_HOME/polybar/helper.sh

is_con_active() {
    return `nmcli connection show --active | grep $1 > /dev/null`
}

if `is_con_active wireguard`; then
    echo " wireguard"

elif `is_con_active vpn_inria`; then
    echo " inria"

else
    print_line " no vpn " $RED

fi
