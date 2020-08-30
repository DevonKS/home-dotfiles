#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

sudo pacman -S i3 dmenu feh polybar rofi dunst

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

#Sauce Code Pro
sudo mkdir -p /usr/share/fonts/sauce-code-pro
sudo cp /home/devon/.i3/fonts/sauce-code-pro/*.ttf /usr/share/fonts/sauce-code-pro/
sudo find /usr/share/fonts/sauce-code-pro -type f -exec chmod 644 -- {} +

#FiraCode Nerd Font
sudo mkdir -p /usr/share/fonts/fira-code-nerd-font
sudo cp /home/devon/.i3/fonts/FiraCodeNerdFont/*.ttf /usr/share/fonts/fira-code-nerd-font/
sudo find /usr/share/fonts/fira-code-nerd-font -type f -exec chmod 644 -- {} +

#refresh font cache
fc-cache -v

#Install xidlehook for autolocking
pamac build xidlehook

#Install rofi theme
sudo cp /home/devon/.i3/themes/rofi/nord-rofi-theme/nord.rasi /usr/share/rofi/themes/
sudo chmod 644 /usr/share/rofi/themes/nord.rasi

sudo cp /home/devon/.i3/themes/rofi/gruvbox-rofi-theme/gruvbox.rasi /usr/share/rofi/themes/
sudo chmod 644 /usr/share/rofi/themes/gruvbox.rasi
