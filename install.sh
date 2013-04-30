#!/bin/bash

EXTRA="${HOME}/.vim/.extra"

# Check if working directory set on the repo

cd "$(dirname "$0")"

if ! [ -f vimrc ]
then
    echo "ERROR: can't find 'vimrc'"
    exit 1
fi

# Check for vim presence

if ! (vim --version || vim -v) > /dev/null 2> /dev/null
then
    echo "ERROR: you must install 'vim'"
    exit 1
fi

# Check for git presence

if ! (git --version || git -v) > /dev/null 2> /dev/null
then
    echo "ERROR: you must install 'git'"
    exit 1
fi

# Check for internet connection (for github)

echo "Checking internet conection..."

if ! ping -w 5000 -c 1 github.com > /dev/null 2> /dev/null &&
   ! ping -W 5000 -c 1 github.com > /dev/null 2> /dev/null
then
    echo "ERROR: you don't have an internet connection or github may be down"
    exit 1
fi

# Make backup

echo "Making backup..."

rm -rf ~/.vimrc.bak ~/.vim.bak 2> /dev/null
mv ~/.vimrc ~/.vimrc.bak 2> /dev/null
mv ~/.vim ~/.vim.bak 2> /dev/null

# Install vundle

echo "Installing vundle..."

if ! git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 2> /dev/null
then
    echo "ERROR: you may not have internet connection, or github may be down, try later"

    mv ~/.vimrc.bak ~/.vimrc 2> /dev/null
    mv ~/.vim.bak ~/.vim 2> /dev/null

    exit 1
fi

# Install

echo "Installing..."

if ! ln vimrc ~/.vimrc > /dev/null 2> /dev/null
then
    echo "Failed to hard-link vimrc, falling back to copy"

    cp vimrc ~/.vimrc
fi

mkdir ~/.vim/.backup
mkdir ~/.vim/.tmp
mkdir ~/.vim/.undo

# Install plugins

echo "Installing plugins..."

vim +BundleInstall +qall

# Install ack

echo "Installing ack..."

mkdir "$EXTRA" > /dev/null 2> /dev/null

if ! (curl --version || curl -v ) > /dev/null 2> /dev/null
then
    echo "You don't have curl, so ack won't be installed"

elif ! curl -# http://beyondgrep.com/ack-2.04-single-file > "${EXTRA}/ack.pl"
then
    echo "Can't get ack, proceding anyway"
else
    chmod 0755 "${EXTRA}/ack.pl"
fi

# Check for exuberant ctags presence

echo "Done!!!"
echo
echo "NOTES:"

if ! (ctags --version | grep -Ei "exuberant") > /dev/null 2> /dev/null &&
   ! (ctags --v       | grep -Ei "exuberant") > /dev/null 2> /dev/null
then
    echo "      You should install 'exuberant ctags' to use the tagbar plugin"
    echo
fi

if ! (perl --version || perl -v) > /dev/null 2> /dev/null
then
    echo "      You should install 'perl' to use the ack plugin"
    echo
fi

echo "      You may want to install and set your terminal to use one of the fonts in"
echo "      '~/.vim/bundle/powerline-fonts' to have a pretty status line"

