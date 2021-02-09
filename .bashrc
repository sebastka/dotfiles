# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nano'

# Compilation flags
export ARCHFLAGS="-arch x86_64"
export MAKEFLAGS="-j12"
alias pmake='make $(MAKEFLAGS)'

# kdesrc-build ##################################################

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

## Run projects built with kdesrc-build
function kdesrc-run
{
	source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/${1##*/}" "${@:2:$#}"
}
#################################################################


mkc () {
	cat << EOF > $1
#include <stdlib.h>
#include <stdio.h>

int main(const int argc, const char** const argv)
{
	printf("hello, world");
	return EXIT_SUCCESS;
}
EOF
}
