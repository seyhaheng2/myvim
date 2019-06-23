#!/bin/bash
#
spctl --master-disable
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install fish
curl -L https://get.oh-my.fish | fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
git config --global color.ui true
git config --global user.name khdaap
git config --global user.email khdaap@gmail.com
ssh-keygen -t rsa -C khdaap@gmail.com

cat ~/.ssh/id_rsa.pub
