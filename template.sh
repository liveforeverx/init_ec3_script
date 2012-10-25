#!/bin/bash

sed -i '$ a\ YOUR_PUBLIC_KEY' .ssh/authorized_keys

sed -i '$ a\deb http://binaries.erlang-solutions.com/debian precise contrib' /etc/apt/sources.list
wget http://binaries.erlang-solutions.com/debian/erlang_solutions.asc
apt-key add erlang_solutions.asc
rm erlang_solutions.asc

apt-get update
apt-get install esl-erlang git make

ERL_LIBS="$HOME/code:$HOME/code/ChicagoBoss/deps/"

# erlang libraries
sed -i '$ a\ERL_LIBS="$HOME/code:$HOME/code/ChicagoBoss/deps/"' ~/.bashrc
sed -i '$ a\export ERL_LIBS'  ~/.bashrc
mkdir code
cd code

git clone https://github.com/evanmiller/ChicagoBoss.git
git clone https://github.com/liveforeverx/tetrapak
git clone https://github.com/liveforeverx/erlcloud
git clone https://github.com/liveforeverx/amazon_lib
git clone https://github.com/liveforeverx/cevent
cd ChicagoBoss
make
cd ../tetrapak
make
sudo ln -s ~/code/tetrapak/bin/tetrapak /usr/local/bin/tetrapak
cd ../erlcloud
tetrapak clean build
tetrapak clean build
cd ../amazon_lib
tetrapak clean build
cd ../cevent
tetrapak clean build
