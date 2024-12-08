#!/usr/bin/env bash

# new-workspace.sh --- jump to the lowest empty workspace.

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

while getopts "hdt" opt; do
    case "$opt" in
	h|help)
	    echo "Usage: new-workspace.sh [OPTIONS]"
	    echo "Switch to the lowest unused workspace."
	    echo
	    echo "OPTIONS"
	    echo "-t, --take-focused    take the current window with you"
	    exit 0
	    ;;
	d|debug)
	    debug="1"
	    shift
	    ;;
	t|take-focused)
            take=$( swaymsg -t get_tree |
			jq '.. | select(.type?) | select(.focused==true) | .id' )
	    shift
	    ;;
	esac
done

workspaces=($( swaymsg -t get_workspaces | jq -r '.[].num' | sort -n ))
next_workspace=$(echo "${workspaces[@]}" |
		     awk -v RS='\\s+' '
		     { a[$1] } END { for(i = 1; i in a; ++i); print i }')

[[ "$debug" ]] && {
    for i in ${workspaces[@]}
    do
	echo "WORKSPACES: $i"
    done
    echo "NEXT: $next_workspace"
}

[[ "$take" ]] && swaymsg "move window to workspace $next_workspace"
swaymsg "workspace $next_workspace"
