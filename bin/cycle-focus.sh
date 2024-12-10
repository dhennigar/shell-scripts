#!/bin/bash

# cycle-focus.sh --- cycle focus on the current workspace.

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

reverse=""
while getopts "hr" opt; do
	case "$opt" in
	h | help)
		echo "Usage: cycle-focus.sh OPTIONS target [runstring]"
		echo
		echo "Cycle focus through the windows on the current workspace."
		echo
		echo "OPTIONS"
		echo "-r|--reverse             cycle in reverse (NOT YET IMPLEMENTED)"
		exit 0
		;;
	r | reverse)
		reverse="set"
		;;
	esac
done

workspace=$(swaymsg -t get_workspaces |
	jq -r '.[] | select(.focused==true) | .name' |
	awk -F':' '{print $1}')

focused=$(swaymsg -t get_tree | jq '.. | select(.type?) |
                                  select(.focused==true) | .id')

window_ids=($(swaymsg -t get_tree |
	jq -r --arg ws $workspace '
                     .. | select(.type?=="workspace" and .name==$ws) |
                     recurse(.nodes[]) | select(.name != null and .type?=="con") |
                     .id'))

if [ -n "$reverse" ]; then
	min=0
	max=$((${#window_ids[@]} - 1))
	while [[ min -lt max ]]; do
		x="${window_ids[$min]}"
		window_ids[$min]="${window_ids[$max]}"
		window_ids[$max]="$x"
		((min++, max--))
	done
fi

if [ -n "$window_ids" ]; then
	found_focused=false
	for window in "${window_ids[@]}"; do
		if $found_focused; then
			swaymsg "[con_id=$window] focus"
			exit 0
		fi
		if [ "$window" = "$focused" ]; then
			found_focused=true
		fi
	done
	first_window=$(echo "$window_ids" | head -n 1)
	swaymsg "[con_id=$first_window]" focus
fi
