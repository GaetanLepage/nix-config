#!/bin/sh

type nmcli >/dev/null 2>&1 || exit

source $XDG_CONFIG_HOME/polybar/scripts/helper.sh

is_con_active() {
    return `nmcli connection show --active | grep $1 > /dev/null`
}

if `is_con_active wireguard`; then
    print_line " wireguard" $GREEN

elif `is_con_active vpn_inria`; then
    print_line " inria" $GREEN

else
    print_line " no vpn" $RED

fi
