#
#	Custom Bash functions
#

# Create base C file
mkc () {
	if [ "$#" -ne 1 ]; then
		echo "Error: no argument provided"
		return 1
	fi

	if [ -f "$1" ]; then
		echo "Error: '$1' already exists"
		return 1
	fi

	echo -ne "#include <stdlib.h>\n#include <stdio.h>\n\nint main(const int argc, const char** const argv)\n{\n\tprintf(\"hello, world\");\n\n\treturn EXIT_SUCCESS;\n}" >> $1

	return 0
}

# Download Win10 ISO (Inspired from https://gist.github.com/hongkongkiwi/15a5bf16437315df256c118c163607cb)
# https://tb.rg-adguard.net/public.php
# https://www.microsoft.com/en-us/software-download/windows10ISO
getWin () {
	# Check args
	if [ "$#" -lt 0 ] || [ "$#" -gt 2 ]; then
		echo "Error: either none or two agrument is required: language (ex: Norwegian) and output file"
		return 1
	fi

	if [ "$#" -eq 0 ] || [ -z "$1" ]; then
		LANG_NAME="English"
	else
		LANG_NAME=$1
	fi

	if [ "$#" -eq 2 ] && [ -z "$2" ]; then
		echo "Error: output file cannot be an empty string"
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
		curl -s -L "$DOWNLOAD_URL" -o "$2"
	else
		curl -s -L "$DOWNLOAD_URL" -o "$FILE_NAME"
	fi

	return 0
}

# Extract Win10 fonts for https://aur.archlinux.org/packages/ttf-ms-win10/
getFonts () {
	# Does wimextract command exist?
	if [ ! command -v wimextract &> /dev/null ]; then
		echo "Error: wimextract command not found. Please install wimlib"
		return 1
	fi

	# If iso provided, does the file exist? If not, fetch it
	if [ "$#" -eq 1 ] && [ -f "$1"]; then
		FILE=$1
	else
		FILE="win.iso"
		getWin "English" "$FILE"
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
	if [ -d ~/.cache/paru/clone/ttf-ms-win10/]; then
		mv fonts/* ~/.cache/paru/clone/ttf-ms-win10/
		rmdir fonts
	fi

	return 0
}