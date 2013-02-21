#!/bin/bash

# Check if working directory set on the repo

if ! [ -f vimrc ]
then
    echo "ERROR: you should 'cd' into the repository"
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

cp vimrc ~/.vimrc

# Install plugins

echo "Installing plugins..."

if (vim --version || vim -v) > /dev/null 2> /dev/null
then
    VI="vim"
else
    VI="vi"
fi

$VI +BundleInstall +qall

# Check for exuberant presence

if ! (ctags --version | egrep -i "exuberant") > /dev/null 2> /dev/null
then
    echo "You should install 'exuberant ctags' to use the tagbar plugin"
fi

echo "Done!!!"
echo
echo "NOTE: You may want to install one of the fonts in"
echo "      '~/.vim/bundle/powerline-fonts'"
echo "      to have a pretty tagbar"

