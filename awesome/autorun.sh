#!/usr/bin/env bash

function run {
	if ! pgrep "$1" ;
	then
		$@&
	fi
}

run nm-applet --sm-disable
run cryptkeeper
run dropbox start -i
run ./.dropbox-dist/dropbox-lnx.x86_64-26.4.24/dropbox

#setxkbmap -layout "us,el"
#setxkbmap -layout "us,el" -option "grp:alt_shift_toggle"

# Enable tap to click and natural scroll
xinput set-prop "SynPS/2 Synaptics TouchPad" "274" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "284" 1
# NOTE: on different HW:
# check available mice: xinput list
# check available properties: xinput list-props "MOUSE NAME"
