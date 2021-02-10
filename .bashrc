#
#	Load ohmybash
#
if test -f /usr/share/oh-my-bash/bashrc; then
	. /usr/share/oh-my-bash/bashrc
fi

#
#	Env vars
#

export LANG=en_US.UTF-8
export EDITOR='nano'
export ARCHFLAGS="-arch x86_64"
export MAKEFLAGS="-j12"

#
#	Aliases
#
alias pmake='make $(MAKEFLAGS)'

#
#	kdesrc-build
#

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

## Run projects built with kdesrc-build
function kdesrc-run
{
	source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/${1##*/}" "${@:2:$#}"
}

#
#	Functions
#

mkc () {
	echo -ne "#include <stdlib.h>\n#include <stdio.h>\n\nint main(const int argc, const char** const argv)\n{\n\tprintf(\"hello, world\");\n\n\treturn EXIT_SUCCESS;\n}" >> $1
}
