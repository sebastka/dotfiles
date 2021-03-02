#!/bin/bash

#
#	Custom Bash functions
#

# Create base C file
mkc () {
	(
		set -e

		USAGE="Usage: mkc filename"

		if [ "$#" -ne 1 ]; then
			echo "Error: no argument provided"
			echo "$USAGE"
			return 1
		fi

		if [ -f "$1" ]; then
			echo "Error: '$1' already exists"
			return 1
		fi

		echo -ne "#include <stdlib.h>\n#include <stdio.h>\n\nint main(const int argc, const char** const argv)\n{\n\tprintf(\"hello, world\");\n\n\treturn EXIT_SUCCESS;\n}" >> $1

		return 0
	)
}

# Open browser tab in explainshell.com
explain () {
	(
		set -e
		
		USAGE="Usage: explain command"

		if [ "$#" -lt 1 ]; then
			echo "Error: no argument provided"
			echo "$USAGE"
			return 1
		fi
		
		arg=`echo "$*" | tr ' ' '+'`

		xdg-open "https://explainshell.com/explain?cmd=$arg"

		return 0
	)
}

# Set a sudo lecturer
set_lecturer () {
	(
		set -e
		USAGE="Usage: set_lecturer lecturer"

		# Groot: https://caferock.org/chris/groot.txt || https://www.cyberciti.biz/files/groot.txt
		# Dinosaurus: https://caferock.org/chris/dinosaurus.txt
		# Tradewars: https://caferock.org/chris/tradewars.txt
		declare -a lecturers=("groot" "dinosaurus" "tradewars" "none")

		if [ "$#" -lt 1 ]; then
			echo "Error: no argument provided"
			echo -e "$USAGE"
			return 1
		fi

		# It's easy to check if an array contains an element in bash
		if [[ ! ${lecturers[*]} =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]; then
			echo "Error: invalid argument provided"
			echo "Available lecturers:"
			printf '\t%s\n' "${lecturers[@]}"
			return 1
		fi

		if [ -f /etc/sudoers.d/lecturer.txt ]; then
			sudo rm /etc/sudoers.d/lecturer.txt
		fi

		if [ -f /etc/sudoers.d/lecture ]; then
			sudo rm /etc/sudoers.d/lecture
		fi

		# Quit now if resetting the lecturer
		if [ $1 == "none" ]; then
			return 0
		fi

		# Quit if missing file in ~/.sudo/
		if [ ! -f ~/.sudo/"$1".txt ] || [ ! -f ~/.sudo/lecture ]; then
			echo "Missing lecturer file in ~/.sudo/"
			return 0
		fi

		# Copy files to /etc/sudoers.d/ and give correct permissions
		sudo cp ~/.sudo/"$1".txt /etc/sudoers.d/lecturer.txt
		sudo cp ~/.sudo/lecture /etc/sudoers.d/lecture

		sudo chmod 0440 /etc/sudoers.d/lecturer.txt
		sudo chmod 0440 /etc/sudoers.d/lecture

		# Reset sudo so the new lecturer can be tested
		sudo --reset-timestamp

		return 0
	)
}

# Download Win10 ISO (Inspired from https://gist.github.com/hongkongkiwi/15a5bf16437315df256c118c163607cb)
# https://tb.rg-adguard.net/public.php
# https://www.microsoft.com/en-us/software-download/windows10ISO
getWin () {
	(
		set -e
		USAGE="Usage: getWin [language [output]]"

		# Check args
		if [ "$#" -lt 0 ] || [ "$#" -gt 2 ]; then
			echo "Error: at most to positional arguments"
			echo "$USAGE"
			return 1
		fi

		if [ "$#" -eq 0 ] || [ -z "$1" ]; then
			LANG_NAME="English"
		else
			LANG_NAME=$1
		fi

		if [ "$#" -eq 2 ] && [ -z "$2" ]; then
			echo "Error: output file cannot be an empty string"
			echo "$USAGE"
			return 0
		fi

		# Get file info
		ARCH="x64"
		LATEST_WINDOWS_VERSION=`curl -s -H "Accept: application/json" "https://tb.rg-adguard.net/php/get_version.php?type_id=1" | jq '.versions | sort_by(-(.version_id | tonumber))[0]'`
		WINDOWS_NAME=`echo "$LATEST_WINDOWS_VERSION" | jq -r .name`
		VERSION_ID=`echo "$LATEST_WINDOWS_VERSION" | jq -r .version_id`
		EDITION_ID=`curl -s -H "Accept: application/json" "https://tb.rg-adguard.net/php/get_edition.php?version_id=${VERSION_ID}&lang=name_en" | jq -r '.editions[] | select(.name_en=="Windows 10").edition_id'`
		LANGUAGE_ID=`curl -s -H "Accept: application/json" "https://tb.rg-adguard.net/php/get_language.php?edition_id=${EDITION_ID}&lang=name_en" | jq -r '.languages[] | select(.name_en=="'${LANG_NAME}'").language_id'`
		ARCH_INFO=`curl -s -H "Accept: application/json" "https://tb.rg-adguard.net/php/get_arch.php?language_id=${LANGUAGE_ID}"`
		FILE_NAME=`echo "$ARCH_INFO" | jq -r '.archs[] | select(.name | contains("'${ARCH}'")).name'`
		ARCH_ID=`echo "$ARCH_INFO" | jq -r '.archs[] | select(.name | contains("'${ARCH}'")).arch_id'`
		DOWNLOAD_INFO=`curl -s "https://tb.rg-adguard.net/dl.php?fileName=${ARCH_ID}&lang=en"`
		DOWNLOAD_ID=`echo "$DOWNLOAD_INFO" | grep -oP '(?<=https:\/\/tb\.rg-adguard\.net/dl\.php\?go=)[0-9a-z]+'`
		DOWNLOAD_URL="https://tb.rg-adguard.net/dl.php?go=${DOWNLOAD_ID}"
		FILE_SIZE_MB=`echo "$DOWNLOAD_INFO" | grep -oP "(?<=File size: </b>)[0-9.]+"`
		FILE_SIZE_BYTES=`echo "$DOWNLOAD_INFO" | grep -oP "(?<=File size: </b>)[0-9(). A-Z]+" | cut -d "(" -f2 | tr -d ' '`

		# If at least one var i empty, abort
		if [ -z "$WINDOWS_NAME" ] || [ -z "$VERSION_ID" ] || [ -z "$EDITION_ID" ] || [ -z "$LANGUAGE_ID" ] || [ -z "$ARCH_INFO" ] || [ -z "$FILE_NAME" ] || [ -z "$ARCH_ID" ] || [ -z "$DOWNLOAD_INFO" ] || [ -z "$DOWNLOAD_ID" ] || [ -z "$DOWNLOAD_URL" ] || [ -z "$FILE_SIZE_MB" ] || [ -z "$FILE_SIZE_BYTES" ]; then
			echo "Error: file not found"
			return 1
		fi

		echo "Found $WINDOWS_NAME"
		if [ -f "$FILE_NAME" ]; then
			EXISTING_BYTES=`stat --printf="%s" "$FILE_NAME"`

			if [ "$EXISTING_BYTES" -eq "$FILE_SIZE_BYTES" ]; then
				echo "File already exists! Skipping download"
				return 0
			else
				echo "File does exist but has wrong bytesize! (got $EXISTING_BYTES expected $FILE_SIZE_BYTES)"
				echo "Probably corrupt or incomplete - removing"
				rm "$FILE_NAME"
			fi
		fi

		echo "Downloading $FILE_NAME ($FILE_SIZE_MB MB [$FILE_SIZE_BYTES bytes])"

		# If second arg is provided, store file to $2
		if [ "$#" -eq 2 ]; then
			FILE_NAME="$2"
		fi

		# Download file
		curl -s -L "$DOWNLOAD_URL" -o "$FILE_NAME"

		# Checksum
		shasum=`sha1sum "$FILE_NAME" | cut -d " " -f1`

		if curl -s https://sha1.rg-adguard.net/search.php?sha1="$shasum" | grep -q "<b>It is found in  msdn.rg-adguard.net:</b> 1"; then
			echo "Checkum OK"
		else
			echo "Cheksum failed! Please try again"
			rm "$FILE_NAME"
			return 1
		fi;

		return 0
	)
}

# Extract Win10 fonts for https://aur.archlinux.org/packages/ttf-ms-win10/
getFonts () {
	(
		set -e
		USAGE="Usage: getFonts [iso]"

		# Does wimextract command exist?
		if ! [ -x "$(command -v wimextract)" ]; then
			echo "Error: wimextract command not found. Please install wimlib"
			return 1
		fi

		# If iso provided, does the file exist? If not, fetch it
		if [ "$#" -eq 1 ] && [ -f "$1" ]; then
			FILE=$1
		elif [ "$#" -eq 1 ] && [ ! -f "$1" ]; then
			echo "Error: file '$1' not found"
			echo "$USAGE"
			return 1
		else
			FILE="win.iso"
			
			if getWin "English" "$FILE"; then
				echo "Download OK"
			else
				echo "Download of ISO failed! Please try again"
				return 1
			fi;
		fi

		# Extract fonts from iso
		mkdir iso
		sudo mount $FILE iso -o loop
		wimextract iso/sources/install.wim 1 /Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf} --dest-dir fonts
		sudo umount iso
		rmdir iso

		# Remove iso if it has not been provided as an argument
		if [ "$#" -eq 0 ]; then
			rm $FILE
		fi

		# If build folder is found, copy fonts to it
		if [ -d ~/.cache/paru/clone/ttf-ms-win10/ ]; then
			cp fonts/* ~/.cache/paru/clone/ttf-ms-win10/
		elif [ -d ~/.cache/yay/clone/ttf-ms-win10/ ]; then
			cp fonts/* ~/.cache/yay/clone/ttf-ms-win10/
		fi

		return 0
	)
}

# Wrap sudo to handle aliases and functions
# https://w00tbl0g.blogspot.com/2007/05/using-bash-functions-under-sudo.html
# https://serverfault.com/questions/177699/how-can-i-execute-a-bash-function-with-sudo
# Wout.Mertens@gmail.com
#
# Accepts -x as well as regular sudo options: this expands variables as you not root
#
# Comments and improvements welcome
#
# Installing: source this from your .bashrc and set alias sudo=sudowrap
#  You can also wrap it in a script that changes your terminal color, like so:
#  function setclr() {
#    local t=0               
#    SetTerminalStyle $1                
#    shift
#    "$@"
#    t=$?
#    SetTerminalStyle default
#    return $t
#  }
#  alias sudo="setclr sudo sudowrap"
#  If SetTerminalStyle is a program that interfaces with your terminal to set its
#  color.

# Note: This script only handles one layer of aliases/functions.

# If you prefer to call this function sudo, uncomment the following
# line which will make sure it can be called that
#typeset -f sudo >/dev/null && unset sudo

# sudowrap () 
# {
# 	local c="" t="" parse=""
# 	local -a opt
# 	#parse sudo args
# 	OPTIND=1
# 	i=0
# 	while getopts xVhlLvkKsHPSb:p:c:a:u: t; do
# 		if [ "$t" = x ]; then
# 			parse=true
# 		else
# 			opt[$i]="-$t"
# 			let i++
			
# 			if [ "$OPTARG" ]; then
# 				opt[$i]="$OPTARG"
# 				let i++
# 			fi
# 		fi
# 	done
	
# 	shift $(( $OPTIND - 1 ))
# 	if [ $# -ge 1 ]; then
# 		c="$1";
# 		shift;
# 		case $(type -t "$c") in 
# 		"")
# 			echo No such command "$c"
# 			return 127
# 			;;
# 		alias)
# 			c="$(type "$c")"
# 			# Strip "... is aliased to `...'"
# 			c="${c#*\`}"
# 			c="${c%\'}"
# 			;;
# 		function)
# 			c="$(type "$c")"
# 			# Strip first line
# 			c="${c#* is a function}"
# 			c="$c;\"$c\""
# 			;;
# 		*)
# 			c="\"$c\""
# 			;;
# 		esac
		
# 		if [ -n "$parse" ]; then
# 			# Quote the rest once, so it gets processed by bash.
# 			# Done this way so variables can get expanded.
# 			while [ -n "$1" ]; do
# 				c="$c \"$1\""
# 				shift
# 			done
# 		else
# 			# Otherwise, quote the arguments. The echo gets an extra
# 			# space to prevent echo from parsing arguments like -n
# 			while [ -n "$1" ]; do
# 				t="${1//\'/\'\\\'\'}"
# 				c="$c '$t'"
# 				shift
# 			done
# 		fi
		
# 		echo sudo "${opt[@]}" -- bash -xvc \""$c"\" >&2
# 		command sudo "${opt[@]}" bash -xvc "$c"
# 	else
# 		echo sudo "${opt[@]}" >&2
# 		command sudo "${opt[@]}"
# 	fi
# }
# # Allow sudowrap to be used in subshells
# export -f sudowrap