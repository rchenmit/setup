#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# change timezone to New York (eastern time)
export TZ=America/New_York

# install git and curl
sudo apt-get install -y git
sudo apt-get install -y curl

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    _now=$(date +"%Y%m%d_%H%M%S")
    _backupdir="dotfiles.old_$_now"
    mv dotfiles "$_backupdir"
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/rchenmit/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

