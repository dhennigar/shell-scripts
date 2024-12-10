#!/bin/bash

# fuzzel-files.sh --- use fuzzel as a file manager

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

cd $HOME
file=1
while [ "$file" ]; do
	file=$(ls -1 --group-directories-first | fuzzel -d -p "$(basename $(pwd))")
	if [ -e "$file" ]; then
		owd=$(pwd)
		if [ -d "$file" ]; then
			cd "$file"
		else
			[ -f "$file" ]
			if which xdg-open &>/dev/null; then
				exec xdg-open "$owd/$file" &
				unset file
			fi
		fi
	fi
done
