#!/bin/sh

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev \
cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev \
libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen \
xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev \
libiw-dev libcurl4-openssl-dev libpulse-dev \
libxcb-composite0-dev xcb libxcb-ewmh2 -y

cd ..
mkdir -p etc
cd etc
# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

cd ../../

git clone --branch 3.3 --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
sudo make install


cd ../../
git clone https://github.com/unix121/i3wm-themer
cd i3wm-themer/
sudo pip install -r requirements.txt
./install_ubuntu.sh
cp -r scripts/* /home/$USER/.config/polybar/
mkdir ~/Backups -p
cd src
python i3wm-themer.py --config config.yaml --backup /home/$USER/Backups
python i3wm-themer.py --config config.yaml --install defaults/
