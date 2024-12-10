#!/bin/bash

# screenshot.sh --- save a screenshot of a screen area with slurp

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

for prog in grim slurp; do
	if which "$prog" &>/dev/null; then
		grim -g "$(slurp)"
		notify-send -t 3000 "Screenshot" "Saved in $GRIM_DEFAULT_DIR"
	else
		notify-send "Install GRIM and SLURP."
	fi
done
