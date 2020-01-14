#!/usr/bin/env python3
"""pavolume - Control PulseAudio Volume from the commandline

Usage:
        pavolume show
        pavolume volup [--nolimit] [--nounmute] [--noshow] [--quiet]
        pavolume volup <volume> [--nolimit] [--nounmute] [--noshow] [--quiet]
        pavolume voldown [--noshow] [--quiet]
        pavolume voldown <volume> [--noshow] [--quiet]
        pavolume volset <volume> [--nounmute] [--noshow] [--quiet]
        pavolume muteon [--noshow] [--quiet]
        pavolume muteoff [--noshow] [--quiet]
        pavolume mutetoggle [--noshow] [--quiet]
        pavolume -h | --help
        pavolume --version

Options:
        --h --help   Show this help.
        --version    Show program version.
        --quiet      Don't play blip sound
        --noshow     Don't show notifications
        --nolimit    Allow increasing the volume over 100%
        --nounmute   Disable the default behavior of un-muting when increasing the volume

"""

from pulseaudio import PulseAudio
from docopt import docopt
from configparser import ConfigParser
import gi
gi.require_version('Notify', '0.7')
from gi.repository import Notify
import os
import math
import subprocess

square_full = "\u25a0"
square_empty = "\u25a1"
square_cross = "\u25a8"

def progress_bar(v_min, v_max, v_current, increment, full_char=square_full, empty_char=square_empty):
    """Render a progress bar out of characters"""
    v_range = (v_max - v_min)
    filled = math.floor((v_current - v_min) / v_range  * increment)
    empty = increment - filled

    overfilled = 0
    if empty < 0:
        empty = 0
        overfilled = filled - increment
        filled = increment

    if overfilled:
        return (full_char * filled) + "|" + (full_char * overfilled)
    else:
        return (full_char * filled) + (empty_char * empty)


scriptdir = os.path.dirname(os.path.realpath(__file__))

# read config
config = ConfigParser()
#config.read([
#    os.path.join(scriptdir, "pavolume.conf"),
#    os.path.expanduser("~/.config/pavolume/pavolume.conf"),
#    "/etc/pavolume/pavolume.conf"
#    ])
config.read("/home/gaetan/.config/pavolume/pavolume.conf")

sink = config.get("Sink", "default_sink")
if sink == "None": sink = None
volume_max = int(config.get("Sink", "volume_max"))
volume_min = int(config.get("Sink", "volume_min"))
volume_increment = int(config.get("Sink", "volume_increment"))
blip_sound = config.get("Sounds", "blip")

Notify.init("pavolume")

def show():
    percent = (pa.get_volume(sink) - volume_min) / (volume_max - volume_min) * 100

    if pa.get_mute(sink):
        title = "Muted %2.0f%%" % percent
        pb = progress_bar(volume_min, volume_max, pa.get_volume(sink), volume_increment, full_char=square_cross)
    else:
        title = "Volume %2.0f%%" % percent
        pb = progress_bar(volume_min, volume_max, pa.get_volume(sink), volume_increment)

    Notify.Notification.new(title, pb, "dialog-information").show()

def volume_set(new_volume, noshow=False, quiet=False):
    pa.set_volume(int(new_volume), sink)
    if not noshow: show()
    if not quiet: blip()

def volume_mod(increments, noshow=False, nolimit=False, quiet=False):

    volume = pa.get_volume(sink)

    print("increm = " + str(volume_increment))
    print("n% = " + str(100 / volume_increment))
    delta = volume_max - volume_min
    increm_pc = volume_increment / delta
    volume = volume + increments * ((volume_max - volume_min) / volume_increment)

    if volume < volume_min: volume = volume_min
    if increments > 0 and volume > volume_max and not nolimit: volume = volume_max

    volume_set(volume, noshow, quiet)

def volume_inc(increments, noshow=False, nolimit=False, quiet=False):
    volume = pa.get_volume(sink)
    volume = (volume + (volume_max - volume_min) * (increments / 100))

    if volume < volume_min: volume = volume_min
    if increments > 0 and volume > volume_max and not nolimit: volume = volume_max

    volume_set(volume, noshow, quiet)

def blip():
    subprocess.Popen(["paplay", blip_sound])



if __name__ == "__main__":

    args = docopt(__doc__, version="pavolume 0.1")

    pa = PulseAudio()
    pa.update()

    if args['show']:
        show()

    elif args['volup']:
        if not args['--nounmute']: pa.set_mute(False, sink)
        if args['<volume>']:
            volume = args['<volume>']
            if '%' in volume:
                volume = int(volume[:volume.find("%")])
            else:
                volume = int(volume)
            volume_inc(volume, args['--noshow'], args['--nolimit'], args['--quiet'])

        else:
            volume_mod(1, args['--noshow'], args['--nolimit'], args['--quiet'])

    elif args['voldown']:
        if args['<volume>']:
            volume = args['<volume>']
            if '%' in volume:
                volume = int(volume[:volume.find("%")])
            else:
                    volume = int(volume)
            volume_inc(-volume, args['--noshow'], args['--nolimit'], args['--quiet'])

        else:
            volume_mod(-1, args['--noshow'], args['--nolimit'], args['--quiet'])

    elif args['volset']:
        volume = args['<volume>']
        if '%' in volume:
            volume = int(volume[:volume.find("%")])
            volume = int(volume_min + (volume_max - volume_min) * (volume / 100))
        else:
            volume = int(volume)

        if not args['--nounmute']: pa.set_mute(False, sink)
        volume_set(volume, args['--noshow'], args['--quiet'])

    elif args['muteon']:
        pa.set_mute(True, sink)
        if not args['--noshow']: show()

        elif args['muteoff']:
            pa.set_mute(False, sink)

        if not args['--noshow']: show()
        if not args['--quiet']: blip()

    elif args['mutetoggle']:
        pa.set_mute(not pa.get_mute(sink), sink)
    if not args['--noshow']: show()
    if not args['--quiet']: blip()

#vim: set filetype=python
