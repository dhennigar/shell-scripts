#!/bin/bash

grim -g "$(slurp)"

notify-send -t 3000 "Screenshot" "Saved in ~/Pictures/Captures"
