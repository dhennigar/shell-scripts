#!/bin/bash

# select-window.sh --- select an i3/sway window using dmenu

# Copyright (c) Adrien Le Guillo (original author, year unknown)
# Copyright (c) Daniel Hennigar (added i3/sway compatibility)

# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# Except as contained in this notice, the name(s) of the above copyright
# holders shall not be used in advertising or otherwise to promote the sale,
# use or other dealings in this Software without prior written authorization.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

set -e # error if a command as non 0 exit
set -u # error if undefined variable

# Default parameters
FORMAT="W:%W | %A - %T"
# FORMAT="%A"
DMENU="dmenu"

# Doc
NAME="$(basename "$0")"
VERSION="0.2"
DESCRIPTION="Window switcher for i3/sway using dmenu"
HELP="
$NAME. $VERSION - $DESCRIPTION

Usage: 
    $NAME [-f | --format <format>] [-d | --dmenu-cmd <command>] 
          [-h | --help] [-v | --version]

Options:
    -d CMD, --dmenu-cmd CMD\t\t[default: \"dmenu\"]
        set the \`dmenu\` command to use (ex \"rofi -dmenu\")

    -f FORMAT, --format FORMAT\t\t[default: \"$FORMAT\"]
        set the format for the window picker
            %O: Output (Display)
            %W: Workspace
            %A: Application
            %T: Window Title
        (window_id) is appended at the end to identify the window

    -v, --version
        print version info and exit

    -h, --help      
        display this help and exit

Examples:
    # Default options work well if you have dmenu installed
    sws.sh

    # Use a different dmenu provider
    sws.sh --dmenu-cmd \"wofi -d\"

    # Add outputs name to the selector
    sws --format \"[%O] W:%W | %A - %T\"
"

# Options parsing
INVALID_ARGS=0
OPTS=$(getopt -n "$NAME" -o f:d:hv \
	--long format:,dmenu-cmd:,help,version -- "$@") || INVALID_ARGS=1

# Exit with error and print $HELP if an invalid argument is passed
# the previous command is allowed to fail for this purpose
if [ "$INVALID_ARGS" -ne "0" ]; then
	echo "$HELP"
	exit 1
fi

# Required for getopt parsing
eval set -- "$OPTS"
unset OPTS

while :; do
	case "$1" in
	-f | --format)
		FORMAT=$2
		shift 2
		;;
	-d | --dmenu-cmd)
		DMENU=$2
		shift 2
		;;
	-h | --help)
		echo "$HELP"
		exit
		;;
	-v | --version)
		echo "Version $VERSION"
		exit
		;;
	--)
		shift
		break
		;;
	*)
		echo "$HELP"
		exit 1
		break
		;;
	esac
done

# Set appopriate MSG for i3/sway
MSG=i3-msg
if [[ -S "SWAYSOCK" ]]
then
    MSG=swaymsg
fi

# FORMAT as a `jq` concatenation string
FORMAT="$FORMAT (%I)"
# Replace tokens using Bash parameter expansion
FORMAT=${FORMAT//%O/"\" + .output + \""}
FORMAT=${FORMAT//%W/"\" + .workspace + \""}
FORMAT=${FORMAT//%A/"\" + .app_id + \""}
FORMAT=${FORMAT//%T/"\" + .name + \""}
FORMAT=${FORMAT//%I/"\" + .id + \""}
# Wrap the entire string in double quotes
FORMAT="\"$FORMAT\""


# Get the container ID from the node tree
CON_ID=$($MSG -t get_tree |
	jq -r ".nodes[] 
        | {output: .name, content: .nodes[]}
        | {output: .output, workspace: .content.name, 
          apps: .content 
            | .. 
            | {id: .id?|tostring, name: .name?, app_id: .app_id?, shell: .shell?} 
            | select(.app_id != null or .shell != null)}
        | {output: .output, workspace: .workspace, 
           id: .apps.id, app_id: .apps.app_id, name: .apps.name }
        | $FORMAT
        | tostring" |
	$DMENU -i -p "Window Switcher > ")

# Requires the actual `id` to be at the end and between paretheses
CON_ID=${CON_ID##*(}
CON_ID=${CON_ID%)}

# Focus on the chosen window
$MSG "[con_id=$CON_ID] focus"
