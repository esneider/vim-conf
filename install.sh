#!/bin/bash

readonly   VUNDLE_URL="https://github.com/gmarik/vundle.git"
readonly    FONTS_URL="https://github.com/Lokaltog/powerline-fonts.git"
readonly GITCTAGS_URL="https://github.com/esneider/gitctags.git"
readonly HOMEBREW_URL="https://raw.github.com/Homebrew/homebrew/go/install"
readonly MAC_LIB_PATH="/Library/Developer/CommandLineTools/usr/lib"

run_silent() {
    eval "(${@}) > /dev/null 2> /dev/null"
}

exists() {
    run_silent "command -v ${1}"
}

error() {
    echo "ERROR: ${1}"
    exit 1
}

warn() {
    echo "WARNING: ${1}"
}

progress() {
    echo "${1}..."
}

install() {
    progress "Installing ${1}"

    if ! run_silent "${@:2}"; then
        warn "failed to install ${1}, proceeding anyway"
    fi
}

npm_install() {
    if exists npm && ! run_silent npm list -g "${1}"; then
        install "${1}" npm install -g "${@}"
    fi
}

brew_install() {
    if exists brew && ! run_silent brew list "${1}"; then
        install "${1}" brew install "${@}"
    fi
}

apt_get_install() {
    if run_silent dpkg-query -Wf'${Status}' "${1}" | grep "^i"; then
        install "${1}" sudo apt-get install -y "${@}"
    fi
}

setup_mac() {
    # Make sure the developer tools are installed and ready

    if ! exists xcode-select; then
        error "you should install Xcode from the App Store"
    fi

    if ! [[ -e ${MAC_LIB_PATH} ]]; then
        install "developer tools" "xcode-select" --install
    fi

    if [[ -e ${MAC_LIB_PATH} ]] && [[ ":${DYLD_LIBRARY_PATH}:" != *":${MAC_LIB_PATH}:"* ]]; then
        echo 'export DYLD_LIBRARY_PATH="'${MAC_LIB_PATH}':${DYLD_LIBRARY_PATH}"' >> ~/.bash_profile
    fi

    # Make sure we have Homebrew

    if ! exists brew; then
        progress "Installing Homebrew"

        if ! ruby -e "$(curl -fsSL ${HOMEBREW_URL})"; then
            error "failed to install homebrew"
        fi

        echo 'export ARCHFLAGS="-arch x86_64"' >> ~/.bash_profile
        echo 'export PATH="$(brew --prefix)/bin:${PATH}"' >> ~/.bash_profile
    fi

    # Install dependencies

    brew_install cmake
    brew_install curl
    brew_install git
    brew_install node
    brew_install ctags
    brew_install ag
    brew_install vim --with-python
}

setup_ubuntu() {
    apt_get_install build-essential
    apt_get_install cmake
    apt_get install python-dev
    apt_get_install libclang-dev
    apt_get_install git
    apt_get_install nodejs
    apt_get_install npm
    apt_get_install exuberant-ctags
    apt_get_install silversearcher-ag
}

initial_setup() {
    # Basic checks

    cd "$(dirname "${0}")"

    if ! [ -f vimrc ]; then
        error "can't find vimrc file"
    fi

    progress "Checking internet connection"

    if ! run_silent ping -w 5000 -c 1 google.com &&
       ! run_silent ping -W 5000 -c 1 google.com
    then
        error "no internet connection"
    fi

    # Try to setup dependencies

    if [[ $(uname -s) == "Darwin" ]] && ! exists port; then
        progress "Setting up dependencies for MacOS"
        setup_mac
    fi

    if [[ $(uname -v) == *"Ubuntu"* ]]; then
        progress "Setting up dependencies for Ubuntu"
        setup_ubuntu
    fi

    if ! exists vim; then
        error "you must install 'vim'"
    fi

    if ! exists git; then
        error "you must install 'git'"
    fi
}

install_vimrc() {
    # Make backup

    progress "Making backup"

    run_silent mv -f ~/.vim ~/.vim.bak
    run_silent mv -f ~/.vimrc ~/.vimrc.bak

    mkdir ~/.vim{,/bundle,/extras,/undo}

    # Install

    progress "Installing vimrc"

    if ! run_silent git clone "${VUNDLE_URL}" ~/.vim/bundle/vundle; then
        run_silent mv -f ~/.vimrc.bak ~/.vimrc
        run_silent mv -f ~/.vim.bak ~/.vim
        error "can't connect to github"
    fi

    if ! run_silent ln vimrc ~/.vimrc; then
        warn "failed to hard-link vimrc, falling back to copy"
        cp vimrc ~/.vimrc
    fi

    vim +PluginInstall +qall
}

final_setup() {
    npm_install jshint
    npm_install csslint

    install "fonts"     git clone "${FONTS_URL}"    "~/.vim/extras/fonts"
    install "git-ctags" git clone "${GITCTAGS_URL}" "~/.vim/extras/gitctags"

    run_silent cd ~/.vim/extras/gitctags && ./setup.sh

    install "tern" cd ~/.vim/bundle/tern_for_vim  && npm install
    install "YCM"  cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
}

initial_setup
install_vimrc
final_setup

echo -e "\nDone!!!\n"
echo -e "\tYou may want to config your terminal to use one of the fonts"
echo -e "\tin '~/.vim/extras/fonts' to have a pretty status bar"
