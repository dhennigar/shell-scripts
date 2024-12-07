#!/bin/bash

# mark-recapture.sh --- mark windows for easy recall

# Options
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

# Variables
marked=$( swaymsg -t get_tree |
	      jq '.. | select(.type?) | select(.marks[]?=="mark")' )

# Main script
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
