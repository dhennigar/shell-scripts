#!/bin/bash

# run-or-raise.sh --- focus target if open. else, exec runstring.

swaymsg "[app_id=$1] focus" >/dev/null 2>&1 || {
	swaymsg "[class=$1] focus" >/dev/null 2>&1 || {
	    swaymsg exec "$2"
	}
}
    

