#!/bin/bash

# clam-shell.sh --- turn monitor on/off with lid switch events

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

if grep -q open /proc/acpi/button/lid/LID/state; then
	swaymsg output eDP-1 enable
else
	swaymsg output eDP-1 disable
fi
