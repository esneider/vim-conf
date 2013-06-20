#!/bin/bash

# Config

EXTRAS_PATH="${HOME}/.vim/.extra"

VUNDLE_URL="https://github.com/gmarik/vundle.git"

ACK_URL="http://beyondgrep.com/ack-2.04-single-file"

# Functions

function run_silent {
    eval "(${1}) > /dev/null 2> /dev/null"
}

function exists {
    run_silent "command -v ${1}"
}

function version_has {
    run_silent "${1} --version | grep -i \"${2}\""
}

function error {
    echo "ERROR: ${1}"
    exit 1
}

function warn {
    echo "WARNING: ${1}"
}

function progress {
    echo "${1}..."
}

function note {
    echo "${1}" | fmt -sw 74 | sed "s/^/      /"
    echo
}

# Check if working directory set on the repo

cd "$(dirname "${0}")"

if ! [ -f vimrc ]
then
    error "can't find 'vimrc'"
fi

# Check for vim presence

if ! exists "vim"
then
    error "you must install 'vim'"
fi

# Check for git presence

if ! exists "git"
then
    error "you must install 'git'"
fi

# Check for internet connection (for github)

progress "Checking internet conection"

if ! run_silent "ping -w 5000 -c 1 github.com" &&
   ! run_silent "ping -W 5000 -c 1 github.com"
then
    error "you don't have an internet connection or github may be down"
fi

# Make backup

progress "Making backup"

run_silent "rm -rf ~/.vimrc.bak ~/.vim.bak"
run_silent "mv ~/.vimrc ~/.vimrc.bak"
run_silent "mv ~/.vim ~/.vim.bak"

# Install vundle

progress "Installing vundle"

if ! git clone "${VUNDLE_URL}" ~/.vim/bundle/vundle 2> /dev/null
then
    run_silent "mv ~/.vimrc.bak ~/.vimrc"
    run_silent "mv ~/.vim.bak ~/.vim"

    error "you may not have internet connection, or github may be down, try later"
fi

# Install

progress "Installing vimrc"

if ! run_silent "ln vimrc ~/.vimrc"
then
    warn "failed to hard-link vimrc, falling back to copy"

    cp vimrc ~/.vimrc
fi

mkdir ~/.vim/.undo

# Install plugins

progress "Installing plugins"

vim +BundleInstall +qall

# Install ack

progress "Installing ack"

run_silent "mkdir \"${EXTRAS_PATH}\""

if ! exists "curl" && ! exists "wget"
then

    warn "you don't have curl nor wget, so ack won't be installed"

elif exists "curl" && curl -# "${ACK_URL}" > "${EXTRAS_PATH}/ack.pl"
then

    chmod 0755 "${EXTRAS_PATH}/ack.pl"

elif exists "wget" && wget -nv -O "${EXTRAS_PATH}/ack.pl" "${ACK_URL}"
then

    chmod 0755 "${EXTRAS_PATH}/ack.pl"
else
    warn "can't get ack, proceding anyway"
fi

# Check plugin dependencies

echo "Done!!!"
echo
echo "NOTES:"

if ! exists "ctags" || ! version_has "ctags" "exuberant"
then
    note "You should install 'exuberant ctags' to use the tagbar plugin"
fi

if ! exists "perl"
then
    note "You should install 'perl' to use the ack plugin"
fi

if ! version_has "vim" "+python"
then
    note "You should install vim with python support (+python) to use the ctrl-p plugin"
fi

note "You may want to install and set your terminal to use one of the fonts in \
      '~/.vim/bundle/powerline-fonts' to have a pretty status line"

