log() {
    echo -e "=> [$(date +%H:%M:%S)] $1"
}

notify_email() {
    subject=$1
    body=${2:-""}

    message="Subject: $subject

$body
"

    echo "$message" | msmtp \
        --auth=on \
        --tls=on \
        --tls-certcheck=off \
        --host mail.glepage.com \
        --port 587 \
        --user backup-tank@glepage.com \
        --from backup-tank@glepage.com \
        --passwordeval "cat $EMAIL_PASSWORD_PATH" \
        -F"tank server" \
        gaetan@glepage.com
}

copy() {
    _source=$1
    _dest=$2

    log "Copying '$_source' to '$_dest'"

    rsync \
        -rah \
        --delete \
        --exclude="__*/" \
        "$_source" "$_dest"
}

_mount() {
    _disk_id=$1
    _map_alias=$2
    _mountpoint=$3

    # Ensure disk is connected
    if [ ! -e "/dev/disk/by-id/$_disk_id" ]; then
        log "Disk is missing! Aborting"
        return 1
    fi

    mkdir -p "$_mountpoint"

    log "Decrypting disk '$_disk_id' to '$_map_alias'"
    cryptsetup open \
        "/dev/disk/by-id/$_disk_id" \
        "$_map_alias" <"$LUKS_PASSWORD_PATH" || echo "Already opened"

    log "Mounting decrypted volume '$_map_alias' to '$_mountpoint'"
    mount \
        --onlyonce \
        "/dev/mapper/$_map_alias" \
        "$_mountpoint" || true
}

backup_profile() {
    profile=$1
    disk_id=$2
    source_dirs=$3

    echo "----------------------------------------------------"
    log "BACKUP profile '$profile'\n"

    mountpoint="/mnt/hdd_$profile"

    if ! _mount "$disk_id" "$profile" "$mountpoint"; then
        notify_email "Backup of profile '$profile' failed"
        return 0
    fi

    for source_dir in $source_dirs; do
        copy "/tank/$source_dir" "$mountpoint/"
    done

    log "Unmounting drive '$profile'"
    umount /dev/mapper/"$profile" || return 0

    log "Closing luks device '$profile'"
    cryptsetup close "$profile"

    echo "Drive unmounted successfully"

    notify_email "Backup of profile '$profile' was successful"
}

backup_profile \
    "gaetan" \
    "wwn-0x50014ee21078f713" \
    "backup gaetan"

backup_profile \
    "lepage" \
    "wwn-0x50014ee21078d565" \
    "backup lepage_family nextcloud"
