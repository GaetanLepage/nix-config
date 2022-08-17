#!/bin/sh


GREEN='b8bb26'
RED='fb4934'

print_line() {
    text=$1
    color=$2
    echo "%{u#$color}%{+u}%{F#$color}$text%{F-}%{-u}"
}

