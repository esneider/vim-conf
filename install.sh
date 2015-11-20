#!/usr/bin/env bash

readonly   VUNDLE_URL="https://github.com/gmarik/vundle.git"
readonly    FONTS_URL="https://github.com/Lokaltog/powerline-fonts.git"
readonly GITCTAGS_URL="https://github.com/esneider/gitctags.git"
readonly HOMEBREW_URL="https://raw.github.com/Homebrew/homebrew/go/install"

silent() {
    eval "(${@}) >/dev/null 2>&1"
}

exists() {
    silent command -v "${1}"
}

error() {
    echo "ERROR: ${1}"
    exit 1
}

install() {
    echo "Installing ${1}..."
    if ! silent "${@:2}"; then
        echo "WARNING: failed to install ${1}"
    fi
}

npm_install() {
    if exists npm && ! silent npm list -g "${1}"; then
        install "${1}" npm install -g "${@}"
    fi
}

pip_install() {
    if exists pip && ! (pip show "${1}" | grep ".") >/dev/null 2>&1; then
        install "${1}" pip install "${@}"
    fi
}

brew_install() {
    if exists brew && ! silent brew list "${1}"; then
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

    if ! silent "xcode-select" -p; then # TODO: is this working?
        install "developer tools" "xcode-select" --install
    fi

    if ! exists brew; then
        echo "Installing homebrew..."

        if ! ruby -e "$(curl -fsSL "${HOMEBREW_URL}")"; then
            error "failed to install homebrew"
        fi

        echo 'export ARCHFLAGS="-arch x86_64"' >> ~/.bash_profile
        echo 'export PATH="$(brew --prefix)/bin:${PATH}"' >> ~/.bash_profile
    fi

    brew_install cmake
    brew_install curl
    brew_install git
    brew_install node
    brew_install shellcheck
    brew_install ctags
    brew_install ag
    brew_install vim
}

setup_ubuntu() {
    sudo apt-get update

    apt_get_install build-essential
    apt_get_install cmake
    apt_get_install python-dev
    apt_get_install libclang-dev
    apt_get_install git
    apt_get_install nodejs
    apt_get_install npm
    apt_get_install shellcheck
    apt_get_install exuberant-ctags
    apt_get_install silversearcher-ag
    apt_get_install vim
}

initial_setup() {
    cd "$(dirname "${0}")"

    if ! [ -f vimrc ]; then
        error "can't find vimrc file"
    fi

    if ! silent ping -w 5000 -c 1 google.com &&
       ! silent ping -W 5000 -c 1 google.com
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

    silent mv -f ~/.vim ~/.vim.bak
    silent mv -f ~/.vimrc ~/.vimrc.bak

    mkdir ~/.vim{,/bundle,/extras,/undo}

    if ! silent git clone "${VUNDLE_URL}" ~/.vim/bundle/vundle; then
        silent mv -f ~/.vimrc.bak ~/.vimrc
        silent mv -f ~/.vim.bak ~/.vim
        error "can't connect to github"
    fi

    if ! silent ln vimrc ~/.vimrc; then
        echo "WARNING: failed to hard-link vimrc, falling back to copy"
        cp vimrc ~/.vimrc
    fi

    vim +PluginInstall +qall
}

final_setup() {
    pip_install flake8
    npm_install jshint
    npm_install csslint
    npm_install instant-markdown-d

    cd ~/.vim/bundle/tern_for_vim
    install "tern" npm install

    cd ~/.vim/bundle/YouCompleteMe
    install "YCM (slooow)" ./install.sh --clang-completer --system-libclang

    cd ~/.vim/extras
    install "fonts" git clone "${FONTS_URL}" fonts
    install "git-ctags" git clone "${GITCTAGS_URL}" gitctags
    silent ./gitctags/setup.sh
}

initial_setup
install_vimrc
final_setup

echo "Done!!!"
echo "Note: Use a font from '~/.vim/extras/fonts' to have a pretty status bar"
