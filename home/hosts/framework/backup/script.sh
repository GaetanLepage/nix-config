notify-send "Starting backup"

DRY_RUN=''
if [ "${1-}" = "-d" ]; then
	DRY_RUN='--dry-run'
fi

dest_path=/tank/gaetan/backup/home

rsync -zravut "$HOME/" server:$dest_path \
	--human-readable \
	--delete \
	--delete-excluded \
	--exclude-from=@excludes@ \
	$DRY_RUN

rsync_exit_code=$?

# Handle exit code 24 (i.e. 'Partial transfer due to vanished source files')
case $rsync_exit_code in
0 | 24)
	success_message="Backup succesfull"
	echo "=> $success_message"
	notify-send "$success_message"

	exit 0
	;;

*)
	error_message="Backup failed with error $rsync_exit_code"
	echo "=> $error_message"
	notify-send "$error_message"

	exit 1
	;;
esac
