#!/bin/bash

sudo dnf install i3 i3status dmenu i3lock xbacklight feh conky polybar rofi -y

#Install j4-dmenu-desktop
sudo dnf install cmake g++ -y
mkdir -p ~/development/i3
cd ~/development/i3
git clone https://github.com/enkore/j4-dmenu-desktop.git
cd j4-dmenu-desktop
cmake .
make
sudo make install

# install the fonts
#NotoSans
sudo mkdir -p /usr/share/fonts/noto-sans
sudo cp /home/devon/.i3/fonts/NotoSans/*.ttf /usr/share/fonts/noto-sans/
sudo find /usr/share/fonts/noto-sans -type f -exec chmod 644 -- {} +

#materialIcons
sudo mkdir -p /usr/share/fonts/material-icons
sudo cp /home/devon/.i3/fonts/MaterialIcons/*.ttf /usr/share/fonts/material-icons/
sudo find /usr/share/fonts/material-icons -type f -exec chmod 644 -- {} +

#font awesome
sudo mkdir -p /usr/share/fonts/font-awesome
sudo cp /home/devon/.i3/fonts/FontAwesome/fontawesome-free-5.13.0-desktop/otfs/*.otf /usr/share/fonts/font-awesome/
sudo cp /home/devon/.i3/fonts/FontAwesome/font-awesome-4.7.0/fonts/*.otf /usr/share/fonts/font-awesome/
sudo find /usr/share/fonts/font-awesome -type f -exec chmod 644 -- {} +

#unifont
sudo mkdir -p /usr/share/fonts/unifont
sudo cp /home/devon/.i3/fonts/unifont/gnu-unifont/*.ttf /usr/share/fonts/unifont/
sudo find /usr/share/fonts/unifont -type f -exec chmod 644 -- {} +

#refresh font cache
fc-cache -v

#Install xidlehook for autolocking
sudo dnf install libxcb libXScrnSaver pulseaudio-libs -y
sudo dnf install rust cargo -y
cargo install xidlehook --bins
