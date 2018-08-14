#!/bin/sh
#------------------------------
# function
#------------------------------
is_empty_dir()
{
	# can't use -empty option, so check each specified directory.
	# return 0; empty
	# return 1; not empty

	ret=`find "$1" -type f | wc -l`

	if [ "$ret" == 0 ]
	then
		return 0
	else
		return 1
	fi
}

sort_files()
{
	# ls, and sort results by timestamps.

	# check empty arguments
	if [ -z "$1" ] || [ ! -d "$1" ]; then return; fi

	for filename in `ls -t "$1"`
	do
		# check empty file, mostly, this is effective for /data/system/dropbox/*.lost
		if [ ! -L "$1"/"$filename" ] && [ -f "$1"/"$filename" ] && [ -s "$1"/"$filename" ]
		then
			echo "$filename"
		fi
	done
}

store_durable()
{
	# check empty arguments
	if [ -z "$1" ] || [ ! -d "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then return; fi

	dir_from="$1"
	dir_dest="$2"
	max_file="$3"

	# check empty directory
	if is_empty_dir "$dir_from"; then return; fi
	if [ ! -d "$dir_dest" ]; then mkdir -p "$dir_dest" -m 0711; fi

	for file in `sort_files "$dir_from" | head -n "$max_file"`
	do
		# copy files from dir_from to dir_dest.
		if cp -afp "$dir_from"/"$file" "$dir_dest"/"$file"
		then
			# if copy had been done successfully, 
			# check dir_dest and remove an oldest files from it.
			if [ `ls "$dir_dest" | wc -l` -gt "$max_file" ]
			then
				remove_file=`sort_files "$dir_dest" | tail -n 1`
				rm "$dir_dest"/"$remove_file"
			fi
		fi
	done
}

#------------------------------
# main
#------------------------------
(
	if [ ! -d /durable/logd ]; then mkdir /durable/logd -m 0711; fi

	# anr
	store_durable /data/anr /durable/logd/anr 1

	# dropbox
	store_durable /data/system/dropbox /durable/logd/dropbox 10


	# tombstones
	store_durable /data/tombstones /durable/logd/tombstones 10
) 2> /dev/null
