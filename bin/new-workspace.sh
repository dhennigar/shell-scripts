#!/usr/bin/env bash

### new-workspace.sh --- jump to the lowest empty workspace.

# Options
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

# Variables
workspaces=($( swaymsg -t get_workspaces | jq -r '.[].num' | sort -n ))
next_workspace=$(echo "${workspaces[@]}" |
		     awk -v RS='\\s+' '
		     { a[$1] } END { for(i = 1; i in a; ++i); print i }')

# Debugging information
[[ "$debug" ]] && {
    for i in ${workspaces[@]}
    do
	echo "WORKSPACES: $i"
    done
    echo "NEXT: $next_workspace"
}

# Main script
[[ "$take" ]] && swaymsg "move window to workspace $next_workspace"
swaymsg "workspace $next_workspace"
