#!/bin/bash

# mark-recapture.sh --- mark windows for easy recall

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

while getopts "hns" opt; do
    case "$opt" in
	h|help)
	    echo "Usage: mark-recapture.sh [OPTIONS]"
	    echo
	    echo "Mark the focused window for easy recall"
	    echo
	    echo "OPTIONS"
	    echo "-n|--new      mark a new window, replacing the old one"
	    echo "-s|--summon   summon the marked window to the current workspace"
	    exit 0
	    ;;
	n|new)
	    new="set"
	    shift
	    ;;
	s|summon)
	    summon="set"
	    shift
	    ;;	
    esac
done

marked=$( swaymsg -t get_tree |
	      jq '.. | select(.type?) | select(.marks[]?=="mark")' )

if [[ "$marked" ]]; then
    if [[ "$new" ]]; then
	swaymsg "[con_id=__focused__] mark --add \"mark\""
    else
	if [[ "$summon" ]]; then
	    swaymsg "[con_mark=mark] move to workspace current"
	fi
	swaymsg "[con_mark=mark] focus"
    fi
else
    swaymsg "[con_id=__focused__] mark --add \"mark\""
fi
