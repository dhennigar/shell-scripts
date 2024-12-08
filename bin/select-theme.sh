#!/bin/bash

# select-theme.sh --- choose a theme and update config files accordingly

# Copyright (c) 2024 Daniel Hennigar
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

if [[ -n "$1" ]]; then
	theme="$1"
else
	theme=$(echo -e "day\nnight\nmorning\nbright\nacme" |
		    fuzzel -d -l 6 -p "Select theme > ");
fi

case $theme in
    day)
	cp ~/.config/alacritty/themes/tomorrow-day.toml \
	   ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
	gsettings set org.gnome.desktop.interface color-scheme prefer-light
	emacsclient -e "(load-theme-disable-others 'drh-tomorrow-day)"
	# Match fuzzel colors with Emacs theme
	sed -i '/^background=/c\background=ffffffff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^text=/c\text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^prompt=/c\prompt=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^placeholder=/c\placeholder=8e908cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^input=/c\input=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^match=/c\match=4271aeff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection=/c\selection=d6d6d6ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-text=/c\selection-text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-match=/c\selection-match=c82829ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^counter=/c\counter=8e908cff' ~/.config/fuzzel/fuzzel.ini
	;;
    night)
	cp ~/.config/alacritty/themes/tomorrow-night.toml \
	   ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	emacsclient -e "(load-theme-disable-others 'drh-tomorrow-night)"
	# Match fuzzel colors with Emacs theme
	sed -i '/^background=/c\background=1d1f21ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^text=/c\text=c5c8c6ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^prompt=/c\prompt=c5c8c6ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^placeholder=/c\placeholder=969896ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^input=/c\input=c5c8c6ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^match=/c\match=81a2beff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection=/c\selection=373b41ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-text=/c\selection-text=c5c8c6ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-match=/c\selection-match=cc6666ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^counter=/c\counter=969896ff' ~/.config/fuzzel/fuzzel.ini
	;;
    morning)
	cp ~/.config/alacritty/themes/tomorrow-morning.toml \
	   ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
	gsettings set org.gnome.desktop.interface color-scheme prefer-light
	emacsclient -e "(load-theme-disable-others 'drh-tomorrow-morning)"
	# Match Fuzzel colors with Emacs theme
	sed -i '/^background=/c\background=fff0d0ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^text=/c\text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^prompt=/c\prompt=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^placeholder=/c\placeholder=8e908cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^input=/c\input=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^match=/c\match=4271aeff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection=/c\selection=e6d6a0ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-text=/c\selection-text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-match=/c\selection-match=c82829ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^counter=/c\counter=8e908cff' ~/.config/fuzzel/fuzzel.ini
	;;
    bright)
	cp ~/.config/alacritty/themes/tomorrow-bright.toml \
	   ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Dark-Grey
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	emacsclient -e "(load-theme-disable-others 'drh-tomorrow-bright)"
	# Match Fuzzel colors with Emacs theme
	sed -i '/^background=/c\background=000000ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^text=/c\text=eaeaeaff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^prompt=/c\prompt=eaeaeaff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^placeholder=/c\placeholder=969896ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^input=/c\input=eaeaeaff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^match=/c\match=7aa6daff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection=/c\selection=424242ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-text=/c\selection-text=eaeaeaff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-match=/c\selection-match=d54e53ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^counter=/c\counter=969896ff' ~/.config/fuzzel/fuzzel.ini
	;;
    acme)
	cp ~/.config/alacritty/themes/acme.toml \
	   ~/.config/alacritty/colors.toml
	gsettings set org.gnome.desktop.interface gtk-theme Mint-Yz-Base-Grey
	gsettings set org.gnome.desktop.interface color-scheme prefer-dark
	emacsclient -e "(load-theme-disable-others 'drh-mono-acme)"
	# Match Fuzzel colors with Emacs theme
	sed -i '/^background=/c\background=fefdcfff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^text=/c\text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^prompt=/c\prompt=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^placeholder=/c\placeholder=8e908cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^input=/c\input=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^match=/c\match=4271aeff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection=/c\selection=e6d6a0ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-text=/c\selection-text=4d4d4cff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^selection-match=/c\selection-match=c82829ff' ~/.config/fuzzel/fuzzel.ini
	sed -i '/^counter=/c\counter=8e908cff' ~/.config/fuzzel/fuzzel.ini
	;;    
esac
