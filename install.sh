#!/usr/bin/env bash

readonly   VUNDLE_URL="https://github.com/gmarik/vundle.git"
readonly    FONTS_URL="https://github.com/Lokaltog/powerline-fonts.git"
readonly GITCTAGS_URL="https://github.com/esneider/gitctags.git"
readonly HOMEBREW_URL="https://raw.github.com/Homebrew/homebrew/go/install"

run_silent() {
    eval "(${@}) >/dev/null 2>&1"
}

exists() {
    run_silent "command -v ${1}"
}

error() {
    echo "ERROR: ${1}"
    exit 1
}

install() {
    echo "Installing ${1}..."
    if ! run_silent "${@:2}"; then
        echo "WARNING: failed to install ${1}"
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
    if ! (dpkg-query -Wf'${Status}' "${1}" | grep "^i") >/dev/null 2>&1; then
        install "${1}" sudo apt-get install -y "${@}"
    fi
}

setup_mac() {
    if ! exists "xcode-select"; then
        error "you should install Xcode from the App Store"
    fi

    if ! run_silent "xcode-select" -p; then # TODO: is this working?
        install "developer tools" "xcode-select" --install
    fi

    if ! exists brew; then
        echo "Installing homebrew..."

        if ! ruby -e "$(curl -fsSL ${HOMEBREW_URL})"; then
            error "failed to install homebrew"
        fi

        echo 'export ARCHFLAGS="-arch x86_64"' >> ~/.bash_profile
        echo 'export PATH="$(brew --prefix)/bin:${PATH}"' >> ~/.bash_profile
    fi

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
    apt_get_install python-dev
    apt_get_install libclang-dev
    apt_get_install git
    apt_get_install nodejs
    apt_get_install npm
    apt_get_install exuberant-ctags
    apt_get_install silversearcher-ag
    apt_get_install vim
}

initial_setup() {
    cd "$(dirname "${0}")"

    if ! [ -f vimrc ]; then
        error "can't find vimrc file"
    fi

    if ! run_silent ping -w 5000 -c 1 google.com &&
       ! run_silent ping -W 5000 -c 1 google.com
    then
        error "no internet connection"
    fi

    if [[ $(uname -s) == "Darwin" ]] && ! exists port; then
        setup_mac
    fi

    if [[ $(uname -v) == *"Ubuntu"* ]]; then
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
    echo "Installing vimrc..."

    run_silent mv -f ~/.vim ~/.vim.bak
    run_silent mv -f ~/.vimrc ~/.vimrc.bak

    mkdir ~/.vim{,/bundle,/extras,/undo}

    if ! run_silent git clone "${VUNDLE_URL}" ~/.vim/bundle/vundle; then
        run_silent mv -f ~/.vimrc.bak ~/.vimrc
        run_silent mv -f ~/.vim.bak ~/.vim
        error "can't connect to github"
    fi

    if ! run_silent ln vimrc ~/.vimrc; then
        echo "WARNING: failed to hard-link vimrc, falling back to copy"
        cp vimrc ~/.vimrc
    fi

    vim +PluginInstall +qall
}

final_setup() {
    npm_install jshint
    npm_install csslint

    cd ~/.vim/bundle/tern_for_vim
    install "tern" npm install
    install "fonts" git clone "${FONTS_URL}" "~/.vim/extras/fonts"
    install "git-ctags" git clone "${GITCTAGS_URL}" "~/.vim/extras/gitctags"
    install "YCM (slooow)" ~/.vim/bundle/YouCompleteMe/install.sh --clang-completer

    run_silent ~/.vim/extras/gitctags/setup.sh
}

initial_setup
install_vimrc
final_setup

echo "Done!!!"
echo "Note: Use a font from '~/.vim/extras/fonts' to have a pretty status bar"
