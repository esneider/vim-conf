#!/bin/bash

# Config

EXTRAS_PATH="${HOME}/.vim/.extra"

VUNDLE_URL="https://github.com/gmarik/vundle.git"

ACK_URL="http://beyondgrep.com/ack-2.12-single-file"

FONTS_URL="https://github.com/Lokaltog/powerline-fonts.git"

GITCTAGS_URL="https://github.com/esneider/gitctags.git"

MAC_LIB_PATH="/Library/Developer/CommandLineTools/usr/lib"

HOMEBREW_URL="https://raw.github.com/Homebrew/homebrew/go/install"

# Functions

function run_silent {
    eval "(${@}) > /dev/null 2> /dev/null"
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
    echo "${@}" | fmt -sw 74 | sed "s/^/      /"
    echo
}

function install {
    progress "Installing ${1}"
    if ! run_silent "${@:2}"; then
        warn "failed to install ${1}, proceeding anyway"
    fi
}

function brew_install {
    if exists brew && ! run_silent brew list "${1}"; then
        install "${1}" brew install "${@}"
    fi
}

function npm_install {
    if exists npm && ! run_silent npm list -g "${1}"; then
        install "${1}" npm install -g "${@}"
    fi
}

function setup_mac {

    # Make sure the developer tools are installed

    if ! exists xcode-select; then
        error "you should install Xcode from the App Store"
    fi

    if ! [[ -e ${MAC_LIB_PATH} ]]; then
        install "developer tools" "xcode-select" --install
    fi

    # Add Xcode libraries to the path (libclang, etc)

    if [[ -e ${MAC_LIB_PATH} ]] &&
       [[ ":${DYLD_LIBRARY_PATH}:" != *":${MAC_LIB_PATH}:"* ]]
    then
        echo 'export DYLD_LIBRARY_PATH="'${MAC_LIB_PATH}':${DYLD_LIBRARY_PATH}"' >> ~/.bash_profile
    fi

    # Make sure we have Homebrew

    if ! exists brew; then

        progress "Installing Homebrew"

        if ! ruby -e "$(curl -fsSL ${HOMEBREW_URL})"; then
            error "failed to install homebrew, aborting"
        fi

        echo 'export ARCHFLAGS="-arch x86_64"' >> ~/.bash_profile
        echo 'export PATH="$(brew --prefix)/bin:${PATH}"' >> ~/.bash_profile
    fi

    # Install dependencies

    brew_install git
    brew_install wget
    brew_install python
    brew_install node
    brew_install ctags
    brew_install ag

    # Install vim with python support

    if ! exists vim ||
       ! version_has vim "+python"
    then
        install "vim" brew install vim --with-python
    fi
}

function setup_ubuntu {

    : # TODO
}

# Check if working directory set on the repo

cd "$(dirname "${0}")"

if ! [ -f vimrc ]
then
    error "can't find 'vimrc'"
fi

# Check for internet connection (for github)

progress "Checking internet connection"

if ! run_silent ping -w 5000 -c 1 github.com &&
   ! run_silent ping -W 5000 -c 1 github.com
then
    error "you don't have an internet connection or github may be down"
fi

# Try to setup dependencies

if [[ $(uname -s) == "Darwin" ]] && ! exists port; then
    progress "Setting up dependencies for MacOS"
    setup_mac
fi

if [[ $(uname -s) == "Linux" ]] && [[ $(uname -v) == *"Ubuntu"* ]]; then
    progress "Setting up dependencies for Ubuntu"
    setup_ubuntu
fi

# Check for vim presence

if ! exists vim
then
    error "you must install 'vim'"
fi

# Check for git presence

if ! exists git
then
    error "you must install 'git'"
fi

# Make backup

progress "Making backup"

run_silent rm -rf ~/.vimrc.bak ~/.vim.bak
run_silent mv ~/.vimrc ~/.vimrc.bak
run_silent mv ~/.vim ~/.vim.bak

# Install vundle

progress "Installing vundle"

if ! run_silent git clone "${VUNDLE_URL}" ~/.vim/bundle/vundle
then
    run_silent mv ~/.vimrc.bak ~/.vimrc
    run_silent mv ~/.vim.bak ~/.vim

    error "you don't have an internet connection or github may be down, try later"
fi

# Install

progress "Installing vimrc"

if ! run_silent ln vimrc ~/.vimrc
then
    warn "failed to hard-link vimrc, falling back to copy"

    cp vimrc ~/.vimrc
fi

mkdir ~/.vim/.undo

# Install plugins

progress "Installing plugins"

vim +PluginInstall +qall

# Install ack

progress "Installing ack"

run_silent mkdir "${EXTRAS_PATH}"

if ! exists curl && ! exists wget
then
    warn "you don't have curl nor wget, so ack won't be installed"

elif exists curl && run_silent curl -o "${EXTRAS_PATH}/ack.pl" "${ACK_URL}"
then
    chmod 0755 "${EXTRAS_PATH}/ack.pl"

elif exists wget && run_silent wget -O "${EXTRAS_PATH}/ack.pl" "${ACK_URL}"
then
    chmod 0755 "${EXTRAS_PATH}/ack.pl"
else
    warn "can't get ack, proceeding anyway"
fi

# Install extras

progress "Installing fonts"

if ! run_silent git clone "${FONTS_URL}" "${EXTRAS_PATH}/fonts"
then
    warn "can't get fonts, proceeding anyway"
fi

progress "Installing automatic git ctags"

if ! run_silent git clone "${GITCTAGS_URL}" "${EXTRAS_PATH}/gitctags"
then
    warn "can't get git ctags, proceeding anyway"

elif ! run_silent "${EXTRAS_PATH}/gitctags/setup.sh"
then
    warn "error installing git ctags, proceeding anyway"
fi

# Install some syntax checkers

npm_install jshint
npm_install csslint

# Check plugin dependencies

echo "Done!!!"
echo
echo "NOTES:"

if ! version_has vim "+python"
then
    note "You should install vim with python support (+python)"
fi

if ! exists ctags || ! version_has ctags "exuberant"
then
    note "You should install 'exuberant ctags' to use tags in vim"
fi

if ! exists perl || ! exists ag
then
    note "You should install 'perl' or 'ag' to use the ack plugin"
fi

if exists gcc
then
    note "If you are going to use C or C++, you should install 'libclang'"
fi

note "You may want to install and set your terminal to use one of the fonts in"\
     "'${EXTRAS_PATH}/fonts' to have a pretty status line"

